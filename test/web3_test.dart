import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'data.dart' as data;

void main() {
  late final PersistanceService perService;
  late final AuthService authService;

  late final Web3Client client;

  setUpAll(() async {
    setupLocator();
    await serviceLocator.allReady();
    client = Web3Client(Config.rpcURL, http.Client());
    perService = serviceLocator<PersistanceService>();
    authService = serviceLocator<AuthService>();
    perService.savePrefString(Config.privateKeyName, data.personalPrivateKey);
  });

  tearDownAll(() async {
    client.dispose();
  });

  setUp(() async {});

  test('send_transaction', () async {
    await authService.tryLoadUserData();

    EthPrivateKey? cred = authService.credentials;
    EthereumAddress? addr = authService.userAddress;

    File abiStringFile =
        File("smartcontract/build/contracts/ProductFactory.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'ProductFactory'),
        EthereumAddress.fromHex(
            jsonDecode(abicode)["networks"]["5777"]["address"]));
    ContractFunction function = contract.function('createProduct');

    BigInt b = BigInt.from(5);
    Transaction trans = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: ['a', 'prova', 'prova', b],
        from: addr);

    String v = await client.sendTransaction(cred!, trans);
    debugPrint(v);
  });

  test('call', () async {
    await authService.tryLoadUserData();

    EthereumAddress? addr = authService.userAddress;

    File abiStringFile = File("smartcontract/build/contracts/Product.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'Product'),
        EthereumAddress.fromHex(data.oneCreatedProduct));
    ContractFunction function = contract.function('getName');

    List<dynamic> params = await client
        .call(sender: addr, contract: contract, function: function, params: []);

    debugPrint(params.first.toString());
  });

  test('get costituents', () async {
    await authService.tryLoadUserData();

    EthereumAddress? addr = authService.userAddress;

    File abiStringFile = File("smartcontract/build/contracts/Product.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'Product'),
        EthereumAddress.fromHex(data.oneCreatedProduct));
    ContractFunction function = contract.function('getProductDetails');

    List<dynamic> params = await client
        .call(sender: addr, contract: contract, function: function, params: []);

    debugPrint(params.toString());
  });

  test('listen event', () async {
    await authService.tryLoadUserData();

    EthPrivateKey? cred = authService.credentials;
    EthereumAddress? addr = authService.userAddress;

    File abiStringFile =
        File("smartcontract/build/contracts/ProductFactory.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'ProductFactory'),
        EthereumAddress.fromHex(
            jsonDecode(abicode)["networks"]["5777"]["address"]));
    ContractFunction function = contract.function('createProduct');

    BigInt b = BigInt.from(9);
    Transaction trans = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: ['test_event', 'test', 'test', b],
        from: addr);

    BigInt cid = await client.getChainId();

    String v = await client.sendTransaction(cred!, trans, chainId: cid.toInt());

    debugPrint(v);

    ContractEvent prodCreated = contract.event('ProductCreated');

    TransactionReceipt? r = await client.getTransactionReceipt(v);

    FilterEvent f = r!.logs.first;

    List<dynamic> res = prodCreated.decodeResults(f.topics!, f.data!);

    debugPrint(res.toString());
  });

  test('client', () async {
    int nid = await client.getNetworkId();
    BigInt cid = await client.getChainId();

    debugPrint("networkId: " + nid.toString() + "  chainId: " + cid.toString());
  });
}
