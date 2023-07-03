import 'dart:convert';
import 'package:acompanhamento_estudantil/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/School.dart';
import '../models/Supplies.dart';
import '../models/Users.dart';
import '../services/school_service.dart';
import '../services/user_service.dart';

class SchoolProvider with ChangeNotifier {
  List<School> schools = [];
  School singleSchool = School("0", "", [], [], "", '');
  Supplies supplie = Supplies('0', "", "", 0.00, "", 0);
  Users user = Users('', '', '', '', '');
  bool editing = false;

  Future<List<School>> list() async {
    schools = await SchoolService().list();
    schools = schools.where((element) => element.userId == user.id).toList();
    return schools;
  }

  Future<List<Users>> listUsers() async {
    var users = await UserService().list();
    return users;
  }

    Future<void> insertUser(Users user) async {
    user.id = await UserService().insert(user);
    notifyListeners();
  }

  Future<void> insert(School school) async {
    school.id = await SchoolService().insert(school);

    schools.add(school);
    notifyListeners();
  }

  Future<void> update(School school) async {
    singleSchool = school;
    notifyListeners();
    await SchoolService().Update(school.id, school.toJson());

    schools.add(school);
  }

  void removeItem(School school, Supplies supplie) async {
    List<Supplies> newListSupplies = [];
    school.supplies.forEach((Supplies element) =>
        {if (element.id != supplie.id) newListSupplies.add(element)});
    singleSchool.supplies = newListSupplies;
    singleSchool = school;
    notifyListeners();
    await SchoolService().Update(school.id, singleSchool.toJson());
  }

  void removeSchool(School newSchool) async {
    List<School> newListSchool = [];
    schools.forEach((School element) =>
        {if (element.id != newSchool.id) newListSchool.add(element)});

    print('TESTE');
      print(newListSchool.first.id);
    schools = newListSchool;
    notifyListeners();

    await SchoolService().delete(newSchool.id);
  }

  void UpdateSupplie(Supplies newSupplie, School sentSchool) async {
    List<Supplies> newListSupplies = [];
    sentSchool.supplies.forEach((Supplies element) => {
          if (element.id == newSupplie.id)
            newListSupplies.add(newSupplie)
          else
            newListSupplies.add(element)
        });

    sentSchool.supplies = newListSupplies;
    supplie = newSupplie;
    singleSchool = sentSchool;

    notifyListeners();

    await SchoolService().Update(sentSchool.id, sentSchool.toJson());
  }
}
