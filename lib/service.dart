import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'package:dapp/service/config.dart';

class Service {
  static late Web3Client web3Client;
  static late Credentials credentials;
  static late EthereumAddress ownAddress;

  Service() {
    init();
  }

  void init() async {
    web3Client = Web3Client(rpcURL, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    credentials = EthPrivateKey.fromHex(privateKey);
    ownAddress = await credentials.extractAddress();
  }

  static Future<DeployedContract> loadContract(
      String contractAddress, String contractName) async {
    String abiStringFile =
        await rootBundle.loadString(contractsPath + contractName + ".json");

    String abi = jsonEncode(jsonDecode(abiStringFile)["abi"]);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  DeployedContract contract = c;
  Future<List<dynamic>> query(String functionName, List<dynamic> Args) async {
    ContractFunction function = contract.function(functionName);

    return await web3Client.call(
        contract: contract, function: function, params: Args);
  }

  Future<String> submitTransaction(DeployedContract contract,
      String functionName, List<dynamic> functionArgs) async {
    ContractFunction function = contract.function(functionName);

    return await web3Client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: function, parameters: functionArgs),
        fetchChainIdFromNetworkId: true);
  }
}
