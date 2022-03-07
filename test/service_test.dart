import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:test/test.dart';

import 'package:manufacturing_tracker/setup/locator.dart';
import 'package:manufacturing_tracker/service/product_service.dart';
import 'package:manufacturing_tracker/service/auth_service.dart';
import 'package:manufacturing_tracker/service/web3_service.dart';
import 'package:web3dart/web3dart.dart';
import 'data.dart' as data;

// before running any test uncomment line 25 and comment lines 27-28 of web3_service.dart

void main() {
  late final AuthService authService;
  late final Web3Service web3service;
  late final ProductService prodService;

  setUpAll(() async {
    setupLocator();
    await serviceLocator.allReady();
    authService = serviceLocator<AuthService>();
    web3service = serviceLocator<Web3Service>();
    prodService = serviceLocator<ProductService>();
    await authService.logIn(data.privateKeyOne);
  });

  tearDownAll(() async {
    await web3service.dispose();
  });

  test('credentials', () async {
    bool res1 = await authService.logOut();
    bool res2 = await authService.logIn(data.privateKeyOne);

    debugPrint('login:' + res1.toString() + ' logout:' + res2.toString());
    debugPrint(authService.userAddress.toString());
    debugPrint(authService.credentials.toString());
  });

  test('set default factory', () async {
    prodService.setProductFactory();
  });

  test('create and retrive product', () async {
    prodService.setProductFactory(data.factoryAddress);

    var hash = await prodService.createProduct('mela', 'contadino', 'milano',
        DateFormat.yMMMd().format(DateTime.now()));

    String addr = await prodService.getNewProductAddress(hash);

    var a = EthereumAddress.fromHex(addr);

    debugPrint(a.toString());
  });

  test('mark as finished', () async {
    prodService.setCurrentProduct(data.createdProductTwo);
    var hash = await prodService.markAsFinished();

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('add costituent', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.createdProductOne);

    var hash = await prodService.addConstituent(data.createdProductTwo);

    bool status = await web3service.getTransactionStatus(hash);

    debugPrint(status.toString());
  });

  test('get costituents', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.createdProductOne);

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
    prodService.setCurrentProduct(data.createdProductOne);

    Map<String, String> details = await prodService.getProductDetails();

    debugPrint(details.toString());
  });

  test('mark used', () async {
    prodService.clearCurrentProduct();
    prodService.setCurrentProduct(data.createdProductOne);

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
        'abcde', 'abcde', 'abcde', DateFormat.yMMMd().format(DateTime.now()));

    String addr = await prodService.getNewProductAddress(hash);

    prodService.setCurrentProduct(addr);

    var hash1 = await prodService.markAsFinished();
    bool status1 = await web3service.getTransactionStatus(hash1);

    await authService.logOut();
    await authService.logIn(data.privateKeyTwo);

    prodService.setCurrentProduct(addr);

    var hash2 = await prodService.transferOwnership();
    bool status2 = await web3service.getTransactionStatus(hash2);

    Map<String, String> map = await prodService.getOldAndNewProductOwner(hash2);

    debugPrint('finished:' + status1.toString());
    debugPrint('transferred:' + status2.toString());
    debugPrint(map.toString());
  });
}
