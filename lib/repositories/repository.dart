import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

abstract class Repository {
  final db = FirebaseFirestore.instance;
  // final _baseUrl = "https://aesflutter-default-rtdb.firebaseio.com/";
  final String _collection;

  Repository(this._collection);

  Future<QuerySnapshot<Map<String, dynamic>>> list() =>
      db.collection(_collection).get();

  Future<DocumentReference<Map<String, dynamic>>> insert(
      Map<String, dynamic> data) => db.collection(_collection).add(data);

  Future<http.Response> getById(String id) {
    final uri = Uri.parse("/$_collection/$id.json");
    return http.get(uri);
  }

  Future<void> update(String id, Map<String, dynamic> data) => db.collection(_collection).doc(id).update(data);

  Future delete(String id) async {
    await db.collection(_collection).doc(id).delete();
  }
}
