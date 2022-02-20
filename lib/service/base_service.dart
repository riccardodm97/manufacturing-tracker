import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:dapp/service/config.dart';
import 'dart:convert';

abstract class BaseService {
  static const String contractsPath = "smartcontract/build/contracts/";

  late Web3Client web3Client;
  late Credentials credentials;
  late EthereumAddress userAddress;

  BaseService(String privateKey) {
    web3Client = Web3Client(Config.rpcURL, http.Client(), socketConnector: () {
      return IOWebSocketChannel.connect(Config.wsURL).cast<String>();
    });
    setUserData(privateKey);
  }

  void setUserData(String privateKey) async {
    credentials = EthPrivateKey.fromHex(privateKey);
    userAddress = await credentials.extractAddress();
  }

  Future<DeployedContract> loadContract(
      String contractAddress, String contractName) async {
    String abiStringFile =
        await rootBundle.loadString(contractsPath + contractName + ".json");

    String abi = jsonEncode(jsonDecode(abiStringFile)["abi"]);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> queryContract(DeployedContract contract,
      String functionName, List<dynamic> functionArgs) async {
    ContractFunction function = contract.function(functionName);

    return await web3Client.call(
        sender: userAddress,
        contract: contract,
        function: function,
        params: functionArgs);
  }

  Future<String> submitTransaction(DeployedContract contract,
      String functionName, List<dynamic> functionArgs) async {
    ContractFunction function = contract.function(functionName);

    return await web3Client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: functionArgs,
            from: userAddress),
        fetchChainIdFromNetworkId: true);
  }

  // TODO listen to events

  // TODO client dispose
}
