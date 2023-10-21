// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/users/domain/usecases/logout_usecase.dart';

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutUsecase logoutUsecase;
  LogoutBloc({required this.logoutUsecase}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is LogoutUserEvent) {
        emit(LogoutLoading());
        final result = await logoutUsecase.call();
        result.fold(
            (failure) => emit(LogoutError()), (unit) => emit(LogoutSuccess()));
      }
    });
  }
}
