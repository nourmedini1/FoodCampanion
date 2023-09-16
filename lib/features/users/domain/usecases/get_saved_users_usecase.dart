import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class GetSavedUsersUsecase {
  final UsersRepository usersRepository;

  GetSavedUsersUsecase({required this.usersRepository});
  Future<Either<Failure, List<UserEntity>>> call() async {
    return await usersRepository.getSavedUsers();
  }
}
