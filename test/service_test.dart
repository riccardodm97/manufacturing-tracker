import 'package:dapp/service/product_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

import 'package:dapp/setup/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistence_service.dart';
import 'package:dapp/service/web3_service.dart';
import 'package:web3dart/web3dart.dart';
import 'data.dart' as data;

void main() {
  late final PersistenceService perService;
  late final AuthService authService;
  late final Web3Service web3service;
  late final ProductService prodService;

  setUpAll(() async {
    setupLocator();
    await serviceLocator.allReady();
    perService = serviceLocator<PersistenceService>();
    authService = serviceLocator<AuthService>();
    web3service = serviceLocator<Web3Service>();
    prodService = serviceLocator<ProductService>();
    await authService.logIn(data.PrivateKeyOne);
  });

  tearDownAll(() async {
    await web3service.dispose();
  });

  test('credentials', () async {
    bool res1 = await authService.logOut();
    bool res2 = await authService.logIn(data.PrivateKeyOne);

    debugPrint('login:' + res1.toString() + ' logout:' + res2.toString());
    debugPrint(authService.userAddress.toString());
    debugPrint(authService.credentials.toString());
  });

  test('create and retrive product', () async {
    prodService.setProductFactory(data.factoryAddress);

    var hash = await prodService.createProduct(
        'mela', 'contadino', 'milano', BigInt.from(7));

    String addr = await prodService.getNewProductAddress(hash);

    var a = EthereumAddress.fromHex(addr);

    debugPrint(a.toString());
  });

  test('mark as finished', () async {
    prodService.setCurrentProduct(data.CreatedProductTwo);
    var hash = await prodService.markAsFinished();

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('add costituent', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.CreatedProductOne);

    var hash = await prodService.addConstituent(data.CreatedProductTwo);

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('get costituents', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.CreatedProductOne);

    List<String> constituents = await prodService.getConstituents();

    debugPrint(constituents.toString());

    for (String element in constituents) {
      prodService.clearCurrentProduct();
      prodService.setCurrentProduct(element);
      debugPrint(await prodService.getName());
    }
  });

  test('get details', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.CreatedProductOne);

    Map<String, String> details = await prodService.getProductDetails();

    debugPrint(details.toString());
  });

  test('mark used', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.CreatedProductOne);

    var hash1 = await prodService.markAsFinished();
    bool status1 = await web3service.getTransactionStatus(hash1);

    var hash2 = await prodService.markAsUsed();
    bool status2 = await web3service.getTransactionStatus(hash2);

    debugPrint(status1.toString());
    debugPrint(status2.toString());
  });

  test('buy product', () async {
    prodService.clearCurrentProduct();
    prodService.clearFactory();

    prodService.setProductFactory(data.factoryAddress);
    var hash = await prodService.createProduct(
        'abcde', 'abcde', 'abcde', BigInt.from(12345));

    String addr = await prodService.getNewProductAddress(hash);

    prodService.setCurrentProduct(addr);

    var hash1 = await prodService.markAsFinished();
    bool status1 = await web3service.getTransactionStatus(hash1);

    await authService.logOut();
    await authService.logIn(data.PrivateKeyTwo);

    prodService.setCurrentProduct(addr);

    var hash2 = await prodService.transferOwnership();
    bool status2 = await web3service.getTransactionStatus(hash2);

    Map<String, String> map = await prodService.getOldAndNewProductOwner(hash2);

    debugPrint('finished:' + status1.toString());
    debugPrint('transferred:' + status2.toString());
    debugPrint(map.toString());
  });
}
