import 'dart:convert';

import 'Supplies.dart';

class School{
  String id;
  String name;
  List<Supplies> supplies;
  List<String> imageUrl;

  School(
    this.id,
    this.name,
    this.supplies,
    this.imageUrl
  );

  School.fromJson(Map<String, dynamic> json) : 
  id = json['id'],
  name = json['name'],
  supplies = listFromJsonSupplies(json),
  imageUrl = listFromJsonImage(json['imageUrl']);

  Map<String, dynamic> toJson() => {
    'name' : name, 
    'supplies' : supplies,
    'imageUrl': imageUrl
  };

  static List<School> listFromJson(Map<String, dynamic> json) {
    List<School>  school = [];
    json.forEach((key, value) {

        Map<String, dynamic> item = {"id": key, ...value};
        school.add(School.fromJson(item));
     });

     return school;
  }

   static List<String> listFromJsonImage(List<dynamic> json) {
    List<String>  images = [];
    json.forEach( (val) => {
        images.add(val)
      });
    // json.forEach((key, value) {
    //     Map<String, dynamic> item = {"id": key, ...value};
    //     images.add(item["url"]);
    //  });
     return images;
  }

    static List<Supplies> listFromJsonSupplies(Map<String, dynamic> json) {
      List<dynamic> listDynamic = [];
      List<Supplies>  supplies = [];
      if(json['supplies'] == null){
          return supplies;
      }

      listDynamic = json['supplies'];
      var id =0;
      
      listDynamic.forEach( (val) => {
        supplies.add(Supplies.fromJsonList(val, id)),
        id++,
      });
    // json.forEach((key, value) {
    //     Map<String, dynamic> item = {"id": key, ...value};
    //     supplies.add(Supplies.fromJson(item));
    //  });
     return supplies;
  }
}