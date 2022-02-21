import 'dart:developer' as dev;

import 'package:dapp/config.dart';
import 'package:dapp/locator.dart';
import 'package:dapp/service/auth_service.dart';
import 'package:dapp/service/persistance_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('credentials', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    setupLocator();
    await serviceLocator.allReady();

    final perService = serviceLocator<PersistanceService>();
    final authService = serviceLocator<AuthService>();

    var v = perService.getString(Config.privateKeyName);

    await authService.tryLoadUserData();
    dev.log(v.toString());
    dev.log(authService.userAddress.toString());
  });
}
