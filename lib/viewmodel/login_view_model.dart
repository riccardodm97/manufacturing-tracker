import 'package:dapp/service/auth_service.dart';
import 'package:dapp/setup/locator.dart';
import 'package:dapp/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

  void login(BuildContext context, String privateKey) async {
    setBusy(true);

    bool temp = await _authService.logIn(privateKey);

    setBusy(false);

    if (!temp) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text('Error'),
              content: Text('Something went wrong with your key. Try again'),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }
}
