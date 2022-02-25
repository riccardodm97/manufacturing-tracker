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
    await Navigator.pushNamed(context, 'logIn');
  }

  void navigateToCreateProductView(BuildContext context) async {
    if (!isLogged) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Jack Berselli'),
              content: Text('Jack'),
            );
          });
    } else {
      await Navigator.pushNamed(context, 'createProduct');
    }
  }

  void navigateFindProductView(BuildContext context) async {
    await Navigator.pushNamed(context, 'findProduct');
  }

  void navigateMyProductsView(BuildContext context) async {
    await Navigator.pushNamed(context, 'myProducts');
  }
}
