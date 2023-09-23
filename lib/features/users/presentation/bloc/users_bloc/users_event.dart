part of 'users_bloc.dart';

sealed class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class UsersUpdateUserEvent extends UsersEvent {
  final UserEntity userEntity;

  const UsersUpdateUserEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class UsersRemoteLoginEvent extends UsersEvent {
  final String email;
  final String password;

  const UsersRemoteLoginEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class UsersLocalLoginEvent extends UsersEvent {
  final String password;
  final UserEntity userEntity;

  const UsersLocalLoginEvent(
      {required this.password, required this.userEntity});
  @override
  List<Object> get props => [password, userEntity];
}

class UsersDeleteUserEvent extends UsersEvent {
  final UserEntity userEntity;

  const UsersDeleteUserEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class UsersSignInEvent extends UsersEvent {
  final UserEntity userEntity;

  const UsersSignInEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}

class UsersGetSavedUsersEvent extends UsersEvent {}
