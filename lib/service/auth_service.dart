import 'package:web3dart/web3dart.dart';

import '../setup/locator.dart';
import 'persistence_service.dart';

class AuthService {
  static const String _privateKeyName = "user_private_key";
  final PersistenceService _persistance = serviceLocator<PersistenceService>();

  EthPrivateKey? _credentials;
  EthereumAddress? _userAddress;

  EthPrivateKey? get credentials => _credentials;
  EthereumAddress? get userAddress => _userAddress;

  bool isUserLoggedIn() {
    return _userAddress != null;
  }

  Future<bool> tryLoadUserData() async {
    String? key = _persistance.getPrefString(_privateKeyName);

    try {
      var cred = EthPrivateKey.fromHex(key!);
      var addr = await cred.extractAddress();
      _credentials = cred;
      _userAddress = addr;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logIn(String privateKey) async {
    await _persistance.savePrefString(_privateKeyName, privateKey);

    return tryLoadUserData();
  }

  Future<bool> logOut() async {
    bool done = await _persistance.removePrefString(_privateKeyName);
    _credentials = null;
    _userAddress = null;
    return done;
  }
}
