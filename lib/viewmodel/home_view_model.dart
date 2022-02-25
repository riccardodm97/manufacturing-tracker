import 'package:dapp/service/auth_service.dart';
import 'package:dapp/setup/locator.dart';
import 'package:dapp/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

  void logOut() async {
    _authService.logOut();
  }

  void navigateToLoginView(BuildContext context) async {
    await Navigator.pushNamed(context, '/logIn');
  }

  void navigateToCreateProductView(BuildContext context) async {
    if (_authService.isUserLoggedIn()) {
      await Navigator.pushNamed(context, '/createProduct');
    } else {
      showTextDialog(context, 'You are not logged in',
          'To create a product you need to logIn first');
    }
  }

  void navigateFindProductView(BuildContext context) async {
    await Navigator.pushNamed(context, '/findProduct');
  }

  void navigateMyProductsView(BuildContext context) async {
    if (_authService.isUserLoggedIn()) {
      await Navigator.pushNamed(context, '/myProducts');
    } else {
      showTextDialog(context, 'You are not logged in',
          'To see your products you need to logIn first');
    }
  }
}
