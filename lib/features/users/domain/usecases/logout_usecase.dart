import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class LogoutUsecase {
  final UsersRepository usersRepository;

  LogoutUsecase({required this.usersRepository});
  Future<Either<Failure, Unit>> call() {
    return usersRepository.logout();
  }
}
