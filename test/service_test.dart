import 'dart:developer' as dev;
import 'package:flutter/cupertino.dart';
import 'package:test/test.dart';

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'package:dapp/service/web3_service.dart';

void main() {
  test('credentials', () async {
    setupLocator();
    await serviceLocator.allReady();

    final perService = serviceLocator<PersistanceService>();
    final authService = serviceLocator<AuthService>();
    final web3Service = serviceLocator<Web3Service>();

    var v = perService.getPrefString(Config.privateKeyName);

    await authService.tryLoadUserData();
    debugPrint(v.toString());
    debugPrint(authService.userAddress.toString());

    await web3Service.dispose();
  });
}
