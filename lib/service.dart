import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

import 'package:dapp/config.dart';

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
    String address,
    String name,
  ) async {
    String abiStringFile = await rootBundle
        .loadString("smartcontract/build/contracts/" + name + ".json");
    var jsonAbi = jsonDecode(abiStringFile);
    String abi = jsonEncode(jsonAbi["abi"]);

    EthereumAddress contractAddress = EthereumAddress.fromHex(address);

    DeployedContract contract = DeployedContract(
      ContractAbi.fromJson(abi, name),
      contractAddress,
    );

    return contract;
  }

  static Future<List<dynamic>> query(
      String contractName,
      String contractAddress,
      String functionName,
      List<dynamic> functionArgs) async {
    DeployedContract contract =
        await loadContract(contractAddress, contractName);
    ContractFunction function = contract.function(functionName);

    List<dynamic> result = await web3Client.call(
        contract: contract, function: function, params: functionArgs);

    return result;
  }

  Future<String> maketransaction(
    String contractName,
    String contractAddress,
    String functionName,
    List<dynamic> functionArgs,
  ) async {
    DeployedContract contract =
        await loadContract(contractAddress, contractName);
    ContractFunction function = contract.function(functionName);

    dynamic result = await web3Client.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: function,
        parameters: functionArgs,
      ),
      fetchChainIdFromNetworkId: true,
      chainId: null,
    );

    return result;
  }
}
