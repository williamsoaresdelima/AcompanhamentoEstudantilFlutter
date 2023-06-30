// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';

// import '../models/Users.dart';
// import '../services/user_service.dart';

// class UserProvider with ChangeNotifier {
//   Users user = Users('', '', '', '', '');

//   // Future<void> insert(Users user) async {
//   //   user.id = await UserService().insert(user);
//   //   notifyListeners();
//   // }

//   //   Future<List<Users>> listUsers() async {
//   //   var users = await UserService().list();
//   //   return users;
//   // }

//   //  Future<bool> login(String email, String password) async {
//   //   final FirebaseAuth auth = FirebaseAuth.instance;
//   //   var userLogin = await auth.signInWithEmailAndPassword(email: email, password: password);
//   //   if(userLogin.user != null) {
  

//   //     var myUser = users.where((element) => element.email == email).first;

//   //     if(myUser != null){
//   //       user = myUser;
//   //       print(user);
//   //        notifyListeners();
//   //       return true;
//   //     }
//   //     else {
//   //        return false;
//   //     }
//   //   }
//   //   else {
//   //     return false;
//   //   }
//   // }
// }
