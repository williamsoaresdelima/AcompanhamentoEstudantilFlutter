import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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
      final response = await _schoolRepository.list();
      return School.listFromJson(response.docs);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<List<School>> Update(String id, Map<String, dynamic> school) async {
    try {
      await _schoolRepository.update(id, school);
      final list = await this.list();
      return list;
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<String> insert(School school) async {
    try {
      final response = await _schoolRepository.insert(school.toJson());
      return response.id;
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
