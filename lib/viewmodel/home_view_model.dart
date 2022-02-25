import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../setup/locator.dart';
import 'base_view_model.dart';

class HomeViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

  void logOut() async {
    _authService.logOut();
  }

  void navigateToLoginView(BuildContext context) async {
    await Navigator.pushNamed(context, '/logIn');
  }

  void navigateToCreateProductView(BuildContext context) async {
    if (isUserLogged) {
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
    if (isUserLogged) {
      await Navigator.pushNamed(context, '/myProducts');
    } else {
      showTextDialog(context, 'You are not logged in',
          'To see your products you need to logIn first');
    }
  }
}
