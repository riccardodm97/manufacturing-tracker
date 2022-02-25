import 'package:flutter/widgets.dart';

import '../setup/locator.dart';
import '../service/auth_service.dart';

class BaseModel extends ChangeNotifier {
  final AuthService _authService = serviceLocator<AuthService>();

  bool get isLogged => _authService.userAddress != null;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
