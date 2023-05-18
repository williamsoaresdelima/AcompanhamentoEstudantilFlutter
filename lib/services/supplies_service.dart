import 'dart:convert';

import 'package:acompanhamento_estudantil/repositories/supplies_repository.dart';
import 'package:http/http.dart';

import '../models/Supplies.dart';

class SuppliesService {
  final SuppliesRepository _suppliesRepository = SuppliesRepository();

  Future<List<Supplies>> list() async {
    try {
      Response response = await _suppliesRepository.list();
      Map<String, dynamic> json = jsonDecode(response.body);
      return Supplies.listFromJson(json);
    }
    catch(err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

    Future<List<Supplies>> insert(Supplies supplies) async {
    try {
      String json = jsonEncode(supplies.toJson());
      Response response = await _suppliesRepository.insert(json);
      return jsonDecode(response.body);
    }
    catch(err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }
}