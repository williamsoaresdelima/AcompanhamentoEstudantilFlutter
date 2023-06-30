

import '../models/Users.dart';
import '../repositories/user_repository.dart';

class UserService {
    final UserRepository _usersRepository = UserRepository();

    
  Future<String> insert(Users users) async {
    try {
      final response = await _usersRepository.insert(users.toJson());
      return response.id;
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }

  Future<List<Users>> list() async {
    try {
      final response = await _usersRepository.list();
      return Users.listFromJson(response.docs);
    } catch (err) {
      print(err);
      throw Exception("Problemas ao consultar lista.");
    }
  }
}