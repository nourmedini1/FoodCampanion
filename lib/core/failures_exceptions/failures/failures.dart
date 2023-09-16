import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginFailure extends Failure {}

class SigninFailure extends Failure {}

class OfflineFailure extends Failure {}
