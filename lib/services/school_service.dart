import 'dart:convert';
import 'package:http/http.dart';

import '../models/School.dart';
import '../repositories/school_repository.dart';

class SchoolService {
  final SchoolRepository _schoolRepository = SchoolRepository();

  Future<List<School>> list() async {
    try {
      Response response = await _schoolRepository.list();
      Map<String, dynamic> json = jsonDecode(response.body);
      return School.listFromJson(json);
    }
    catch(err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

   Future<List<School>> Update(String id, String school) async {
    try {
      Response response = await _schoolRepository.update(id, school);
      Map<String, dynamic> json = jsonDecode(response.body);
      return School.listFromJson(json);
    }
    catch(err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }
}