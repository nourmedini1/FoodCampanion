import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/users/data/datasources/local/app_database.dart';

import '../../models/user_model.dart';

abstract class LocalDatasource {
  Future<Unit> saveUser(UserModel userModel);
  UserModel loginLocal(String password, UserModel userModel);
  Future<List<UserModel>> getSavedUsers();
  Future<Unit> updateLocal(UserModel userModel);
  Future<Unit> deleteUser(UserModel userModel);
}

class LocalDataSourceImpl extends LocalDatasource {
  final AppDatabase appDatabase;

  LocalDataSourceImpl({required this.appDatabase});
  @override
  Future<List<UserModel>> getSavedUsers() async {
    final List<UserModel> savedUsers =
        await appDatabase.userDao.getSavedUsers();
    if (savedUsers.isNotEmpty) {
      return savedUsers;
    } else {
      throw EmptyLocalDataBaseException();
    }
  }

  @override
  UserModel loginLocal(String password, UserModel userModel) {
    if (password == userModel.password) {
      return userModel;
    } else {
      throw LocalLoginException();
    }
  }

  @override
  Future<Unit> saveUser(UserModel userModel) async {
    try {
      await appDatabase.userDao.saveUser(userModel);
      return Future.value(unit);
    } catch (e) {
      throw SaveUserException();
    }
  }

  @override
  Future<Unit> updateLocal(UserModel userModel) async {
    try {
      await appDatabase.userDao.updateSavedUser(userModel);
      return Future.value(unit);
    } catch (e) {
      throw LocalUpdateException();
    }
  }

  @override
  Future<Unit> deleteUser(UserModel userModel) async {
    try {
      await appDatabase.userDao.deleteUser(userModel);
      return Future.value(unit);
    } catch (e) {
      throw DeleteUserException();
    }
  }
}
