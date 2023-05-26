import 'dart:convert';
import 'package:http/http.dart';
import '../models/School.dart';
import '../repositories/school_repository.dart';
import 'package:http/http.dart' as http;

class SchoolService {
  final _key = "AIzaSyBaSib038pliNynRUQ8oPCbEF_6D_Bs5vs";
  final _urlGoogle = "https://maps.googleapis.com/maps/api/geocode/json?";
  final SchoolRepository _schoolRepository = SchoolRepository();

  Future<List<School>> list() async {
    try {
      Response response = await _schoolRepository.list();
      Map<String, dynamic> json = jsonDecode(response.body);
      return School.listFromJson(json);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<List<School>> Update(String id, String school) async {
    try {
      Response response = await _schoolRepository.update(id, school);
      Map<String, dynamic> json = jsonDecode(response.body);
      return School.listFromJson(json);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<List<School>> insert(School school) async {
    try {
      String json = jsonEncode(school.toJson());
      Response response = await _schoolRepository.insert(json);
      return jsonDecode(response.body);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<List<School>> delete(String Id) async {
    try {
      Response response = await _schoolRepository.delete(Id);
      return jsonDecode(response.body);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<Map<String, dynamic>> getAddress(double? lat, double? long) async {
    final uri = Uri.parse("${_urlGoogle}latlng=${lat},${long}&key=${_key}");
    Response response = await http.get(uri);
    return jsonDecode(response.body);
  }
}
