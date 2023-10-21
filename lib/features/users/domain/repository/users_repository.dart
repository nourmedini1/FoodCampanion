import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';

abstract class UsersRepository {
  Future<Either<Failure, Unit>> loginRemote(
      String email, String password); // shared Preferences
  Either<Failure, Unit> loginLocal(
      String password, UserEntity userEntity); // shared prefernces
  Future<Either<Failure, UserEntity>> signIn(
      UserEntity userEntity); // shared Preferences
  Future<Either<Failure, Unit>> saveUser(UserEntity userEntity);
  Future<Either<Failure, List<UserEntity>>> getSavedUsers();
  Future<Either<Failure, Unit>> deleteUser(UserEntity userEntity);
  Future<Either<Failure, Unit>> updateUser(
      UserEntity userEntity); // shared preferences
  Future<Either<Failure, Unit>> logout();
}
