import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PersistenceService {
  final SharedPreferences _prefs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> addElementToDocumentList(
      String collection, String doc, String listName, String element) async {
    Map<String, dynamic> data = {
      listName: FieldValue.arrayUnion([element])
    };
    return await firestore
        .collection(collection)
        .doc(doc)
        .set(data, SetOptions(merge: true));
  }

  Future<void> deleteElementFromDocumentList(
      String collection, String doc, String listName, String element) async {
    Map<String, dynamic> data = {
      listName: FieldValue.arrayRemove([element])
    };
    return await firestore
        .collection(collection)
        .doc(doc)
        .set(data, SetOptions(merge: true));
  }
}
