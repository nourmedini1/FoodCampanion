import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login(UserEntity userEntity);
  Future<Either<Failure, Unit>> signIn(UserEntity userEntity);
}
