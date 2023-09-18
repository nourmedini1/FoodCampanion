import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/get_saved_users_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/login_local_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/login_remote_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/save_user_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/sign_in_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/update_user_usecase.dart';
import 'package:food_campanion/features/users/utils/strings.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  DeleteUserUsecase deleteUserUsecase;
  GetSavedUsersUsecase getSavedUsersUsecase;
  LoginLocalUsecase loginLocalUsecase;
  LoginRemoteUsecase loginRemoteUsecase;
  SaveUserUsecase saveUserUsecase;
  SignInUsecase signInUsecase;
  UpdateUserUsecase updateUserUsecase;

  UsersBloc(
      {required this.deleteUserUsecase,
      required this.getSavedUsersUsecase,
      required this.loginLocalUsecase,
      required this.loginRemoteUsecase,
      required this.saveUserUsecase,
      required this.signInUsecase,
      required this.updateUserUsecase})
      : super(UsersInitial()) {
    on<UsersEvent>((event, emit) async {
      if (event is UsersSignInEvent) {
        print("signing in");
        emit(UsersLoadingState());
        final result = await signInUsecase.call(event.userEntity);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: SIGN_IN_SUCCESS_MESSAGE)));
      } else if (event is UsersLocalLoginEvent) {
        emit(UsersLoadingState());
        final result = loginLocalUsecase.call(event.password, event.userEntity);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: LOG_IN_SUCCESS_MESSAGE)));
      } else if (event is UsersRemoteLoginEvent) {
        emit(UsersLoadingState());
        final result =
            await loginRemoteUsecase.call(event.email, event.password);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: LOG_IN_SUCCESS_MESSAGE)));
      } else if (event is UsersSaveUserEvent) {
        emit(UsersLoadingState());
        final result = await saveUserUsecase.call(event.userEntity);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: SAVE_USER_SUCCESS_MESSAGE)));
      } else if (event is UsersDeleteUserEvent) {
        emit(UsersLoadingState());
        final result = await deleteUserUsecase.call(event.userEntity);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: DELETE_USER_SUCCESS_MESSAGE)));
      } else if (event is UsersUpdateUserEvent) {
        emit(UsersLoadingState());
        final result = await updateUserUsecase.call(event.userEntity);
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (unit) => emit(const UsersSuccessState(
                successMessage: UPDATE_USER_SUCCESS_MESSAGE)));
      } else if (event is UsersGetSavedUsersEvent) {
        emit(UsersLoadingState());
        final result = await getSavedUsersUsecase.call();
        result.fold(
            (failure) => emit(
                UsersErrorState(errorMessage: mapFailureToMessage(failure))),
            (savedUsers) => emit(UsersLoadedState(userEntities: savedUsers)));
      }
    });
  }
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case EmptyLocalDatabaseFailure:
        return EMPTY_LOCAL_DATABASE_ERROR_MESSAGE;
      case RemoteLoginFailure:
        return LOG_IN_ERROR_MESSAGE;
      case LocalLoginFailure:
        return LOG_IN_ERROR_MESSAGE;
      case SigninFailure:
        return SIGN_IN_ERROR_MESSAGE;
      case SaveUserFailure:
        return SAVE_USER_ERROR_MESSAGE;
      case DeleteUserFailure:
        return DELETE_USER_ERROR_MESSAGE;
      case RemoteUpdateFailure:
        return UPDATE_USER_ERROR_MESSAGE;
      case LocalUpdateFailure:
        return UPDATE_USER_ERROR_MESSAGE;
      case OfflineFailure:
        return OFFLINE_ERROR_MESSAGE;
      default:
        return UNKNOWN_ERROR_MESSAGE;
    }
  }
}
