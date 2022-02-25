import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../setup/locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();

  bool _busy = false;
  bool get busy => _busy;

  bool get isUserLogged {
    notifyListeners();
    return _authService.isUserLoggedIn();
  }

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void showTextDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
          );
        });
  }
}
