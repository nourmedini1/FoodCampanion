import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';

import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class DeleteUserUsecase {
  final UsersRepository usersRepository;

  DeleteUserUsecase({required this.usersRepository});
  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await usersRepository.deleteUser(userEntity);
  }
}
