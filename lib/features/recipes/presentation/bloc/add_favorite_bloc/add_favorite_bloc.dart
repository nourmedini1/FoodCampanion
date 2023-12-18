import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/domain/usecases/add_to_favorites_usecase.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  final AddToFavoritesUsecase addToFavoritesUsecase;
  AddFavoriteBloc({required this.addToFavoritesUsecase})
      : super(AddFavoriteInitial()) {
    on<AddFavoriteEvent>((event, emit) async {
      if (event is AddFavoriteRecipeEvent) {
        emit(AddFavoriteLoading());
        final result =
            await addToFavoritesUsecase.call(event.recipe, event.userId);
        result.fold((failure) => emit(AddFavoriteError()),
            (unit) => emit(AddFavoriteSuccess()));
      } else if (event is AddFavoriteInitialize) {
        emit(AddFavoriteInitial());
      }
    });
  }
}
