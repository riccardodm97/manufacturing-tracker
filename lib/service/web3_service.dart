import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';

class Web3Service {
  static const String contractsPath = "smartcontract/build/contracts/";

  final AuthService _authService = serviceLocator<AuthService>();

  final Web3Client web3Client =
      Web3Client(Config.rpcURL, http.Client(), socketConnector: () {
    return IOWebSocketChannel.connect(Config.wsURL).cast<String>();
  });

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
        sender: _authService.userAddress,
        contract: contract,
        function: function,
        params: functionArgs);
  }

  Future<String> submitTransaction(DeployedContract contract,
      String functionName, List<dynamic> functionArgs) async {
    ContractFunction function = contract.function(functionName);

    return await web3Client.sendTransaction(
        _authService.credentials!, // TODO handle the null case
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: functionArgs,
            from: _authService.userAddress));
  }

  // TODO listen to events

  // TODO client dispose
}