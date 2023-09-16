import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class UpdateUserUsecase {
  final UsersRepository usersRepository;

  UpdateUserUsecase({required this.usersRepository});
  Future<Either<Failure, UserEntity>> call(UserEntity userEntity) async {
    return await usersRepository.updateUser(userEntity);
  }
}
