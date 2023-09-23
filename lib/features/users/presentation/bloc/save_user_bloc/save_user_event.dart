part of 'save_user_bloc.dart';

sealed class SaveUserEvent extends Equatable {
  const SaveUserEvent();

  @override
  List<Object> get props => [];
}

class SaveUserSaveEvent extends SaveUserEvent {
  final UserEntity userEntity;

  const SaveUserSaveEvent({required this.userEntity});
  @override
  List<Object> get props => [userEntity];
}
