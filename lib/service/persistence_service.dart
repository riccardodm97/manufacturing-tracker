import 'package:shared_preferences/shared_preferences.dart';

class PersistenceService {
  final SharedPreferences _prefs;

  PersistenceService._create(this._prefs);

  static Future<PersistenceService> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return PersistenceService._create(prefs);
  }

  Future<void> savePrefString(String name, String value) async {
    await _prefs.setString(name, value);
  }

  String? getPrefString(String name) {
    return _prefs.getString(name);
  }
}
