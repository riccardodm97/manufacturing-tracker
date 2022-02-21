import 'dart:convert';
import 'dart:io';
import 'dart:developer' as dev;
import 'package:flutter_test/flutter_test.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'data.dart' as data;

void main() {
  test('send_transaction', () async {
    setupLocator();
    await serviceLocator.allReady();

    final perService = serviceLocator<PersistanceService>();
    final authService = serviceLocator<AuthService>();

    late final Web3Client client;
    client = Web3Client(Config.rpcURL, http.Client());

    perService.saveString(Config.privateKeyName, data.personalPrivateKey);

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

    var v = await client.sendTransaction(cred!, trans);
    dev.log(v.toString());
  });

  test('call', () async {
    setupLocator();
    await serviceLocator.allReady();

    final authService = serviceLocator<AuthService>();

    late final Web3Client client;
    client = Web3Client(Config.rpcURL, http.Client());

    await authService.tryLoadUserData();

    EthereumAddress? addr = authService.userAddress;

    File abiStringFile = File("smartcontract/build/contracts/Product.json");
    String abicode = await abiStringFile.readAsString();
    String abi = jsonEncode(jsonDecode(abicode)['abi']);

    DeployedContract contract = DeployedContract(
        ContractAbi.fromJson(abi, 'Product'),
        EthereumAddress.fromHex('0x57dbada2ed1b6797a41f291cffb75c7d52d76c8a'));
    ContractFunction function = contract.function('getProductDetails');

    List<dynamic> params = await client
        .call(sender: addr, contract: contract, function: function, params: []);

    dev.log(params.toString());
  });
}
