import 'package:flutter/material.dart';

import '../service/auth_service.dart';
import '../setup/locator.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();

  bool _busy = false;
  bool get busy => _busy;

  bool get isUserLogged => _authService.isUserLoggedIn();

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

  void showTextDialog(BuildContext context, bool isDismissible, String title,
      String content, List<Widget>? buttonList) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            title: Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.bold)),
            content: Text(content,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.04)),
            actions: buttonList,
          );
        });
  }
}
