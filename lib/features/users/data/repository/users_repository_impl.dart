import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/core/network/internet_checker.dart';
import 'package:food_campanion/features/users/data/datasources/local/local_datasource.dart';
import 'package:food_campanion/features/users/data/datasources/remote/remote_datasource.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';
import 'package:food_campanion/features/users/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsersRepositoryImpl extends UsersRepository {
  final LocalDatasource localDatasource;
  final RemoteDatasource remoteDatasource;
  final InternetChecker internetChecker;
  final SharedPreferences sharedPreferences;

  UsersRepositoryImpl(
      {required this.sharedPreferences,
      required this.internetChecker,
      required this.localDatasource,
      required this.remoteDatasource});
  @override
  Future<Either<Failure, Unit>> deleteUser(UserEntity userEntity) async {
    try {
      await localDatasource.deleteUser(UserModel.fromEntity(userEntity));
      return right(unit);
    } on DeleteUserException {
      return left(DeleteUserFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getSavedUsers() async {
    try {
      final result = await localDatasource.getSavedUsers();
      return right(result);
    } on EmptyLocalDataBaseException {
      return left(EmptyLocalDatabaseFailure());
    }
  }

  @override
  Either<Failure, Unit> loginLocal(String password, UserEntity userEntity) {
    try {
      final result = localDatasource.loginLocal(
          password, UserModel.fromEntity(userEntity));
      sharedPreferences.setString(CURRENT_USER, json.encode(result.toJson()));
      sharedPreferences.setBool(LOGGED_IN, true);
      return right(unit);
    } on LocalLoginException {
      return left(LocalLoginFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> loginRemote(
      String email, String password) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await remoteDatasource.loginRemote(email, password);
        sharedPreferences.setString(CURRENT_USER, json.encode(result.toJson()));
        sharedPreferences.setBool(LOGGED_IN, true);
        return right(unit);
      } on RemoteLoginException {
        return left(RemoteLoginFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveUser(UserEntity userEntity) async {
    try {
      await localDatasource.saveUser(UserModel.fromEntity(userEntity));
      return right(unit);
    } on SaveUserException {
      return left(SaveUserFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn(UserEntity userEntity) async {
    if (await internetChecker.isConnected) {
      try {
        final result =
            await remoteDatasource.signIn(UserModel.fromEntity(userEntity));
        sharedPreferences.setString(CURRENT_USER, json.encode(result.toJson()));
        sharedPreferences.setBool(LOGGED_IN, true);
        return right(result);
      } on SigninException {
        return left(SigninFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity userEntity) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await remoteDatasource
            .updateRemote(UserModel.fromEntity(userEntity));
        try {
          await localDatasource.updateLocal(UserModel.fromEntity(userEntity));
          sharedPreferences.setString(
              CURRENT_USER, json.encode(result.toJson()));
        } on LocalUpdateException {
          return left(LocalUpdateFailure());
        }

        return right(unit);
      } on RemoteUpdateException {
        return left(RemoteUpdateFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await localDatasource.logout();
      return right(unit);
    } on LogoutException {
      return left(LogoutFailure());
    }
  }
}
