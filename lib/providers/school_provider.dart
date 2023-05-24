import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/School.dart';
import '../models/Supplies.dart';
import '../services/school_service.dart';

class SchoolProvider with ChangeNotifier{
  
  List<School> schools = [
  ];
  School singleSchool = School("0", "", [], []);

    Future<List<School>> list() async {
      schools = await SchoolService().list();
      return schools;
   }

   void insert(School school) async {
      await SchoolService().insert(school);
      schools.add(school);
    }

    Future<void> update(School school) async {
      singleSchool = school;
      notifyListeners();
      await SchoolService().Update(school.id ,jsonEncode(school.toJson()));
      schools.add(school);
    }

    void removeItem(School school, Supplies supplie) async {
      List<Supplies> newListSupplies = [];
      school.supplies.forEach((Supplies element) => {
            if(element.id != supplie.id)
                  newListSupplies.add(element)
      });
      singleSchool.supplies = newListSupplies;
      singleSchool = school;
      notifyListeners();
      await SchoolService().Update(school.id, jsonEncode(singleSchool.toJson()));  
    }
}