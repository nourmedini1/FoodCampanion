part of 'users_bloc.dart';

sealed class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

final class UsersInitial extends UsersState {}

class UsersLoadingState extends UsersState {}

class UsersSuccessState extends UsersState {
  final String successMessage;

  const UsersSuccessState({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class UsersErrorState extends UsersState {
  final String errorMessage;

  const UsersErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class UsersLoadedState extends UsersState {
  final List<UserEntity> userEntities;

  const UsersLoadedState({required this.userEntities});
  @override
  List<Object> get props => [userEntities];
}
