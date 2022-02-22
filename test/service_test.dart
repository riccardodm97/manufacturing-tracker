import 'package:dapp/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'package:dapp/service/web3_service.dart';
import 'package:web3dart/web3dart.dart';
import 'data.dart' as data;

void main() {
  late final PersistanceService perService;
  late final AuthService authService;
  late final Web3Service web3service;
  late final ProductService prodService;

  setUpAll(() async {
    setupLocator();
    await serviceLocator.allReady();
    perService = serviceLocator<PersistanceService>();
    authService = serviceLocator<AuthService>();
    web3service = serviceLocator<Web3Service>();
    prodService = serviceLocator<ProductService>();
    perService.savePrefString(Config.privateKeyName, data.personalPrivateKey);
  });

  tearDownAll(() async {
    await web3service.dispose();
  });

  test('credentials', () async {
    var v = perService.getPrefString(Config.privateKeyName);

    await authService.tryLoadUserData();
    debugPrint(v.toString());
    debugPrint(authService.userAddress.toString());
  });

  test('create and retrive product', () async {
    await authService.tryLoadUserData();

    var factoryAddress = data.factoryAddress;
    prodService.setFactoryProduct(factoryAddress);

    var hash = await prodService.createProduct(
        'farina', 'conad', 'bologna', BigInt.from(15));

    String addr = await prodService.getNewProductAddress(hash);

    var a = EthereumAddress.fromHex(addr);

    debugPrint(a.toString());
  });

  test('mark as finished', () async {
    await authService.tryLoadUserData();

    prodService.setCurrentProduct(data.twoCreatedProduct);
    var hash = await prodService.markAsFinished();

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('add costituent', () async {
    await authService.tryLoadUserData();

    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.oneCreatedProduct);

    var hash = await prodService.addConstituent(data.twoCreatedProduct);

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('get costituents', () async {
    await authService.tryLoadUserData();

    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.oneCreatedProduct);

    List<String> constituents = await prodService.getConstituents();

    debugPrint(constituents.toString());

    for (String element in constituents) {
      prodService.clearCurrentProduct();
      prodService.setCurrentProduct(element);
      debugPrint(await prodService.getName());
    }
  });
}
