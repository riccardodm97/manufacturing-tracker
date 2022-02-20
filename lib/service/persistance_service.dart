import 'package:shared_preferences/shared_preferences.dart';

class PersistanceService {
  SharedPreferences prefs;

  PersistanceService._create(this.prefs);

  Future<PersistanceService> init() async {
    prefs = await SharedPreferences.getInstance();

    return PersistanceService._create(prefs);
  }

  Future<void> saveString(String name, String value) async {
    await prefs.setString(name, value);
  }

  Future<String?> getString(String name) async {
    return prefs.getString(name);
  }
}
