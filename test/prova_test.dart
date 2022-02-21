import 'dart:convert';
import 'dart:io';

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'package:dapp/service/product_service.dart';
import 'package:dapp/service/web3_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

void main() {
  test('prova', () async {
    bool d = Random().nextBool();
    List<String>? c;

    if (d) {
      c = null;
    } else {
      c = ['a', 'b'];
    }

    var v = c?.length;

    print(v);
    print(d);
  });
  test('prova1', () async {
    HttpOverrides.global = null;
    TestWidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await serviceLocator.allReady();

    final p_service = serviceLocator<ProductService>();
    final per_service = serviceLocator<PersistanceService>();
    final a_service = serviceLocator<AuthService>();

    // per_service.saveString(Config.privateKeyName,
    //     "2d0977ca3c6ce9332d01a9fbf4445e462aede799c931a3a5ba95238233ae69df");
    var v = per_service.getString(Config.privateKeyName);

    await a_service.tryLoadUserData();
    print(v);
    print(a_service.userAddress);

    await p_service
        .setFactoryProduct("0xC369A5F5e1ca3668b04a5edA5a23aEe9B42cdBf6");
    BigInt b = BigInt.from(5);
    var f = await p_service.createProduct('a', 'prova', 'prova', b);

    print(f);
  });

  test('prova2', () async {
    setupLocator();
    await serviceLocator.allReady();

    final p_service = serviceLocator<ProductService>();
    final per_service = serviceLocator<PersistanceService>();
    final a_service = serviceLocator<AuthService>();
    final web3_service = serviceLocator<Web3Service>();

    late final Web3Client client;
    client = Web3Client(Config.rpcURL, http.Client());

    per_service.saveString(Config.privateKeyName,
        "6585305091aaad4bc9af48bf2c55afe888733abc0125b869bc50b01d7223b2cd");

    await a_service.tryLoadUserData();

    EthPrivateKey? cred = a_service.credentials;
    EthereumAddress? addr = a_service.userAddress;

    File abiStringFile =
        File("smartcontract/build/contracts/ProductFactory.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'ProductFactory'),
        EthereumAddress.fromHex('0xa5bf0F275AC9cc0a062F5a0Ef3Ac67c21946eDEc'));
    ContractFunction function = contract.function('createProduct');

    BigInt b = BigInt.from(5);
    Transaction trans = Transaction.callContract(
        contract: contract,
        function: function,
        parameters: ['a', 'prova', 'prova', b],
        from: addr);

    await client.sendTransaction(cred!, trans);
  });

  test('prova3', () async {
    setupLocator();
    await serviceLocator.allReady();

    final p_service = serviceLocator<ProductService>();
    final per_service = serviceLocator<PersistanceService>();
    final a_service = serviceLocator<AuthService>();
    final web3_service = serviceLocator<Web3Service>();

    late final Web3Client client;
    client = Web3Client(Config.rpcURL, http.Client());

    // per_service.saveString(Config.privateKeyName,
    //     "6585305091aaad4bc9af48bf2c55afe888733abc0125b869bc50b01d7223b2cd");

    await a_service.tryLoadUserData();

    EthPrivateKey? cred = a_service.credentials;
    EthereumAddress? addr = a_service.userAddress;

    File abiStringFile = File("smartcontract/build/contracts/Product.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'Product'),
        EthereumAddress.fromHex('0x57dbada2ed1b6797a41f291cffb75c7d52d76c8a'));
    ContractFunction function = contract.function('getProductDetails');

    // BigInt b = BigInt.from(5);
    // Transaction trans = Transaction.callContract(
    //     contract: contract,
    //     function: function,
    //     parameters: ['a', 'prova', 'prova', b],
    //     from: addr);

    List<dynamic> params = await client
        .call(sender: addr, contract: contract, function: function, params: []);

    print(params);
  });
}
