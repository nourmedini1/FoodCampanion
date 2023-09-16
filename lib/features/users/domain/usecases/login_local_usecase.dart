import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class LoginLocalUsecase {
  final UsersRepository usersRepository;

  LoginLocalUsecase({required this.usersRepository});
  Either<Failure, Unit> call(String password, UserEntity userEntity) {
    return usersRepository.loginLocal(password, userEntity);
  }
}
