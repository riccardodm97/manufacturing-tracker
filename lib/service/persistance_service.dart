import 'package:shared_preferences/shared_preferences.dart';

class PersistanceService {
  final SharedPreferences _prefs;

  PersistanceService._create(this._prefs);

  static Future<PersistanceService> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return PersistanceService._create(prefs);
  }

  Future<void> saveString(String name, String value) async {
    await _prefs.setString(name, value);
  }

  String? getString(String name) {
    return _prefs.getString(name);
  }
}
