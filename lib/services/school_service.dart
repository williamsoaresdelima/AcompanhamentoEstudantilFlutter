import 'dart:convert';
import 'package:http/http.dart';
import 'package:location/location.dart';
import '../models/School.dart';
import '../repositories/school_repository.dart';

class SchoolService {
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

  Future<LocationData> GetPermission() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) Future.value(null);
    }

    _permissionGranted = await location.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) Future.value(null);
    }

   return await location.getLocation();
  }
}
