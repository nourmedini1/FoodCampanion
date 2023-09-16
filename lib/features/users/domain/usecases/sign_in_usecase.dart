import 'package:dartz/dartz.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

import '../../../../core/failures_exceptions/failures/failures.dart';

class SignInUsecase {
  final UsersRepository usersRepository;

  SignInUsecase({required this.usersRepository});
  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await usersRepository.signIn(userEntity);
  }
}
