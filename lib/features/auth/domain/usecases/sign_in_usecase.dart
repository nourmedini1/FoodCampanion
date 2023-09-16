import 'package:dartz/dartz.dart';
import 'package:food_campanion/features/auth/domain/entities/user_entity.dart';
import 'package:food_campanion/features/auth/domain/repository/auth_repository.dart';

import '../../../../core/failures_exceptions/failures/failures.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase({required this.authRepository});
  Future<Either<Failure, Unit>> call(UserEntity userEntity) async {
    return await authRepository.signIn(userEntity);
  }
}
