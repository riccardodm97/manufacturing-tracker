import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../setup/locator.dart';
import 'base_view_model.dart';

class HomeViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

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
      showTextDialog(context, 'You are not logged in',
          'To create a product you need to logIn first');
    }
  }

  Future<void> navigateFindProductView(BuildContext context) async {
    await Navigator.pushNamed(context, '/findProduct');
  }

  Future<void> navigateMyProductsView(BuildContext context) async {
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/myProducts');
    } else {
      showTextDialog(context, 'You are not logged in',
          'To see your products you need to logIn first');
    }
  }
}
