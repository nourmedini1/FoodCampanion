import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';

class LoginRemoteUsecase {
  final UsersRepository usersRepository;

  LoginRemoteUsecase({required this.usersRepository});
  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await usersRepository.loginRemote(email, password);
  }
}
