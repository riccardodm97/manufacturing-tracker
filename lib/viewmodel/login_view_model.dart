import 'package:dapp/service/auth_service.dart';
import 'package:dapp/setup/locator.dart';
import 'package:dapp/viewmodel/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseModel {
  final AuthService _authService = serviceLocator<AuthService>();

  void login(BuildContext context, String privateKey) async {
    setBusy(true);
    bool success = await _authService.logIn(privateKey);
    setBusy(false);

    if (!success) {
      showTextDialog(
          context, 'Error', 'Something went wrong with your key. Try again');
    } else {
      Navigator.pop(context);
    }
  }
}
