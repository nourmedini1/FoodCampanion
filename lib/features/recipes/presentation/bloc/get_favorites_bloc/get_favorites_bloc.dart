import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_favorites_usecase.dart';

part 'get_favorites_event.dart';
part 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesState> {
  final GetFavoritesUsecase getFavoritesUsecase;
  GetFavoritesBloc({required this.getFavoritesUsecase})
      : super(GetFavoritesInitial()) {
    on<GetFavoritesEvent>((event, emit) async {
      if (event is GetFavoritesRecipesEvent) {
        emit(GetFavoritesLoading());
        final result = await getFavoritesUsecase.call(event.userId);
        result.fold(
            (failure) => emit(GetFavoritesError()),
            (favorites) =>
                emit(GetFavoritesSuccess(favorites: favorites.list)));
      }
    });
  }
}
