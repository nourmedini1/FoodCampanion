import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/users/domain/entities/user_entity.dart';
import 'package:food_campanion/features/users/domain/usecases/save_user_usecase.dart';
import 'package:food_campanion/features/users/utils/strings.dart';

part 'save_user_event.dart';
part 'save_user_state.dart';

class SaveUserBloc extends Bloc<SaveUserEvent, SaveUserState> {
  final SaveUserUsecase saveUserUsecase;
  SaveUserBloc({required this.saveUserUsecase}) : super(SaveUserInitial()) {
    on<SaveUserEvent>((event, emit) async {
      if (event is SaveUserSaveEvent) {
        emit(SaveUserLoadingState());
        final result = await saveUserUsecase.call(event.userEntity);
        result.fold(
            (failure) => emit(const SaveUserErrorState(
                errorMessage: SAVE_USER_ERROR_MESSAGE)),
            (unit) => emit(const SaveUserSuccessState(
                successMessage: SAVE_USER_SUCCESS_MESSAGE)));
      }
    });
  }
}
