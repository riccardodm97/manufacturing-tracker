import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../setup/locator.dart';
import 'base_view_model.dart';

class HomeViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

  Future<void> login(BuildContext context, String privateKey) async {
    setBusy(true);
    bool success = await _authService.logIn(privateKey);
    setBusy(false);

    if (!success) {
      showTextDialog(context, true, 'Error',
          'Something went wrong with your key. Try again!', null);
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> logOut() async {
    await _authService.logOut();
    notifyListeners();
  }

  Future<void> navigateToLoginView(BuildContext context) async {
    await Navigator.pushNamed(context, '/logIn');
    notifyListeners();
  }

  Future<void> navigateToCreateProductView(BuildContext context) async {
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/createProduct');
    } else {
      showTextDialog(context, true, 'You are not logged in',
          'To create a product you need to logIn first', null);
    }
  }

  Future<void> navigateFindProductView(BuildContext context) async {
    await Navigator.pushNamed(context, '/findProduct');
  }

  Future<void> navigateMyProductsView(BuildContext context) async {
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/myProducts');
    } else {
      showTextDialog(context, true, 'You are not logged in',
          'To see your products you need to logIn first', null);
    }
  }
}
