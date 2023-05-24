import 'Supplies.dart';

class School{
  String id;
  String name;
  List<Supplies> supplies;

  School(
    this.id,
    this.name,
    this.supplies
  );

  School.fromJson(Map<String, dynamic> json) : 
  id = json['id'],
  name = json['name'],
  supplies = listFromJsonSupplies(json['supplies']);


  Map<String, dynamic> toJson() => {
    'name' : name, 
    'supplies' : supplies
  };

  static List<School> listFromJson(Map<String, dynamic> json) {
         print(json);
    List<School>  school = [];
    json.forEach((key, value) {
        Map<String, dynamic> item = {"id": key, ...value};
        school.add(School.fromJson(item));
     });

     return school;
  }

    static List<Supplies> listFromJsonSupplies(Map<String, dynamic> json) {
     print(json);
    List<Supplies>  supplies = [];
    json.forEach((key, value) {
        Map<String, dynamic> item = {"id": key, ...value};
        supplies.add(Supplies.fromJson(item));
     });
     return supplies;
  }
}