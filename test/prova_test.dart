import 'dart:io';

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'package:dapp/service/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math';

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
}
