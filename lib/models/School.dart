import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'Supplies.dart';

class School {
  String id;
  String name;
  String location;
  List<Supplies> supplies;
  List<String> imageUrl;

  School(this.id, this.name, this.supplies, this.imageUrl, this.location);

  School.fromJson(this.id, Map<String, dynamic> json)
      : name = json['name'],
        location = json['location'],
        supplies = listFromJsonSupplies(json['supplies']),
        imageUrl = listFromJsonImage(json['imageUrl']);

  Map<String, dynamic> toJson() => {
        'name': name,
        'supplies': ListSuppliesToJson(supplies),
        'imageUrl': imageUrl,
        'location': location,
      };

  static List<Map<String, dynamic>> ListSuppliesToJson(List<Supplies> newSupplies) 
  {
    List<Map<String, dynamic>> toJson = [];
    newSupplies.forEach((element) {
      toJson.add(element.toJson());
    });
    return toJson;
  }

  static List<School> listFromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> json) {
    List<School> school = [];

    json.forEach((value) {
      school.add(School.fromJson(value.id, value.data()));
    });
    return school;
  }

  static List<String> listFromJsonImage(List<dynamic> json) {
    List<String> images = [];
    json.forEach((val) => {images.add(val)});
    return images;
  }

  static List<Supplies> listFromJsonSupplies(List<dynamic> listDynamic) {
    List<Supplies> supplies = [];
    if (listDynamic == []) {
      return supplies;
    }
    var id = 0;

    listDynamic.forEach((val) => {
          supplies.add(Supplies.fromJsonList(val, id.toString())),
          id++,
        });

    return supplies;
  }
}
