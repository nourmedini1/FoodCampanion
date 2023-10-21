import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/users/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

abstract class LocalDatasource {
  Future<Unit> saveUser(UserModel userModel);
  UserModel loginLocal(String password, UserModel userModel);
  Future<List<UserModel>> getSavedUsers();
  Future<Unit> updateLocal(UserModel userModel);
  Future<Unit> deleteUser(UserModel userModel);
  Future<Unit> logout();
}

class LocalDataSourceImpl extends LocalDatasource {
  SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<UserModel>> getSavedUsers() {
    final List<String>? savedUsers =
        sharedPreferences.getStringList('SAVED_USERS');
    if (savedUsers != null) {
      if (savedUsers.isNotEmpty) {
        final savedUsersMap = savedUsers
            .map<Map<String, dynamic>>((user) => json.decode(user))
            .toList();
        final savedUsersModel = savedUsersMap
            .map<UserModel>((jsonUser) => UserModel.fromJson(jsonUser))
            .toList();
        return Future.value(savedUsersModel);
      } else {
        throw EmptyLocalDataBaseException();
      }
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
  Future<Unit> saveUser(UserModel userModel) {
    List<String> toAdd = [];
    try {
      List<String>? savedUsers = sharedPreferences.getStringList('SAVED_USERS');
      if (savedUsers != null) {
        savedUsers.add(json.encode(userModel.toJson()));
        toAdd = savedUsers;
      } else {
        toAdd = [json.encode(userModel.toJson())];
      }
      sharedPreferences.setStringList('SAVED_USERS', toAdd);

      return Future.value(unit);
    } catch (e) {
      throw SaveUserException();
    }
  }

  @override
  Future<Unit> updateLocal(UserModel userModel) async {
    try {
      List<String>? savedUsers = sharedPreferences.getStringList('SAVED_USERS');
      if (savedUsers != null) {
        final savedUsersMap = savedUsers
            .map<Map<String, dynamic>>((user) => json.decode(user))
            .toList();
        final savedUsersModel = savedUsersMap
            .map<UserModel>((jsonUser) => UserModel.fromJson(jsonUser))
            .toList();
        savedUsersModel.removeWhere((element) => element.id == userModel.id);
        savedUsersModel.add(userModel);
        final List<String> listUserStrings = savedUsersModel
            .map<String>((user) => json.encode(user.toJson()))
            .toList();
        sharedPreferences.setStringList('SAVED_USERS', listUserStrings);
      }
      return Future.value(unit);
    } catch (e) {
      throw LocalUpdateException();
    }
  }

  @override
  Future<Unit> deleteUser(UserModel userModel) {
    try {
      List<String>? savedUsers = sharedPreferences.getStringList('SAVED_USERS');
      final savedUsersMap = savedUsers
          ?.map<Map<String, dynamic>>((user) => json.decode(user))
          .toList();
      final savedUsersModel = savedUsersMap!
          .map<UserModel>((jsonUser) => UserModel.fromJson(jsonUser))
          .toList();
      savedUsersModel.removeWhere((element) => element == userModel);
      final List<String> listUserStrings = savedUsersModel
          .map<String>((user) => json.encode(user.toJson()))
          .toList();
      sharedPreferences.setStringList('SAVED_USERS', listUserStrings);
      return Future.value(unit);
    } catch (e) {
      throw DeleteUserException();
    }
  }

  @override
  Future<Unit> logout() {
    try {
      sharedPreferences.setString(CURRENT_USER, '');
      return Future.value(unit);
    } catch (e) {
      throw LogoutException();
    }
  }
}
