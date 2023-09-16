import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class RemoteLoginFailure extends Failure {}

class LocalLoginFailure extends Failure {}

class SaveUserFailure extends Failure {}

class RemoteUpdateFailure extends Failure {}

class LocalUpdateFailure extends Failure {}

class EmptyLocalDatabaseFailure extends Failure {}

class DeleteUserFailure extends Failure {}

class SigninFailure extends Failure {}

class OfflineFailure extends Failure {}
