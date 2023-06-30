import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String id;
  String email;
  String fullName;
  String userName;
  String adress;

  Users(
    this.id,
    this.email,
    this.fullName,
    this.userName,
    this.adress,
  );

  Users.fromJson(this.id, Map<String, dynamic> json)
      : email = json['email'],
        fullName = json['fullName'],
        userName = json['userName'],
        adress = json['adress'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'fullName': fullName,
        'userName': userName,
        'adress': adress
      };

  
  static List<Users> listFromJson(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> json) {
    List<Users> user = [];

    json.forEach((value) {
      user.add(Users.fromJson(value.id, value.data()));
    });
    return user;
  }
}
