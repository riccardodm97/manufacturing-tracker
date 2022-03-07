import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

import '../setup/config.dart';
import '../setup/locator.dart';
import '../service/auth_service.dart';

class Web3Service {
  static const String contractsPath = "smartcontract/build/contracts/";

  final AuthService _authService = serviceLocator<AuthService>();
  final Web3Client web3Client;

  Web3Service()
      : web3Client =
            Web3Client(Config.rpcURL, http.Client(), socketConnector: () {
          return IOWebSocketChannel.connect(Config.wsURL).cast<String>();
        });

  Future<DeployedContract> loadContract(
      String contractName, String? contractAddress) async {
    // String stringFile = File(contractsPath + contractName + ".json").readAsStringSync());

    var stringFile = jsonDecode(
        await rootBundle.loadString(contractsPath + contractName + ".json"));

    String abi = jsonEncode(stringFile["abi"]);

    contractAddress ??= stringFile["networks"]["5777"]["address"];

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, contractName),
        EthereumAddress.fromHex(contractAddress!));

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

    BigInt chainId = await web3Client.getChainId();

    return await web3Client.sendTransaction(
        _authService.credentials!,
        Transaction.callContract(
            contract: contract,
            function: function,
            parameters: functionArgs,
            from: _authService.userAddress),
        chainId: chainId.toInt());
  }

  Future<List<dynamic>> extractEventDataFromReceipt(DeployedContract contract,
      String eventName, String transactionHash, int eventIndex) async {
    ContractEvent event = contract.event(eventName);

    TransactionReceipt? receipt =
        await web3Client.getTransactionReceipt(transactionHash);

    FilterEvent eventLog = receipt!.logs[eventIndex];

    return event.decodeResults(eventLog.topics!, eventLog.data!);
  }

  Future<bool> getTransactionStatus(String transactionHash) async {
    TransactionReceipt? receipt =
        await web3Client.getTransactionReceipt(transactionHash);

    return receipt!.status!;
  }

  Future<void> dispose() async {
    return await web3Client.dispose();
  }
}
