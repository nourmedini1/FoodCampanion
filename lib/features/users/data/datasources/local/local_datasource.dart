import 'package:dartz/dartz.dart';

import '../../models/user_model.dart';

abstract class LocalDatasource {
  Future<Unit> saveUser(UserModel userModel);
  Future<Unit> loginLocal(String password, String email);
  Future<List<UserModel>> getSavedUsers();
  Future<Unit> updateLocal(UserModel userModel);
}
