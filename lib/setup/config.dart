class Config {
  static const String _rpcURL = "http://10.0.2.2:7545";
  static const String _wsURL = "ws://10.0.2.2:7545/";

  static String get rpcURL => _rpcURL;
  static String get wsURL => _wsURL;
}

// you can select the host and port from the server menu in the ganache app and copy it here 
// LOCALHOST: "http://127.0.0.1:7545/"
// EMULATOR LOCALHOST: "http://10.0.2.2:7545/"
// you can also use here your wifi url