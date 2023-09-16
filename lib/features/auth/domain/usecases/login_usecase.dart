import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/auth/domain/entities/user_entity.dart';
import 'package:food_campanion/features/auth/domain/repository/auth_repository.dart';

class LoginUsecase {
  final AuthRepository authRepository;

  LoginUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await authRepository.login(userEntity);
  }
}
