class Config {
  static const String _rpcURL = "http://127.0.0.1:7545";
  static const String _wsURL = "ws://127.0.0.1:7545/";

  static const String _privateKeyName = "private_key";

  static String get rpcURL => _rpcURL;
  static String get wsURL => _wsURL;
  static String get privateKeyName => _privateKeyName;
}
