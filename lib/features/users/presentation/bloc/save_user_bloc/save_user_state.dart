part of 'save_user_bloc.dart';

sealed class SaveUserState extends Equatable {
  const SaveUserState();

  @override
  List<Object> get props => [];
}

final class SaveUserInitial extends SaveUserState {}

class SaveUserLoadingState extends SaveUserState {}

class SaveUserSuccessState extends SaveUserState {
  final String successMessage;

  const SaveUserSuccessState({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class SaveUserErrorState extends SaveUserState {
  final String errorMessage;

  const SaveUserErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
