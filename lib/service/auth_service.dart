import 'package:web3dart/web3dart.dart';

import '../setup/locator.dart';
import '../setup/config.dart';
import 'persistence_service.dart';

class AuthService {
  final PersistenceService _persistance = serviceLocator<PersistenceService>();

  EthPrivateKey? _credentials;
  EthereumAddress? _userAddress;

  Future<void> tryLoadUserData() async {
    String? key = _persistance.getPrefString(Config.privateKeyName);

    var cred = (key == null) ? null : EthPrivateKey.fromHex(key);
    var addr = await cred?.extractAddress();

    _credentials = cred;
    _userAddress = addr;
  }

  EthPrivateKey? get credentials => _credentials;
  EthereumAddress? get userAddress => _userAddress;

  // TODO temporaneo, da cambiare con la logica di persitance
  // TODO mettere un try catch o qualcosa per gestire una bad key dell'utente
  // TODO gestire la cancellazione delle credenziali con logout
}
