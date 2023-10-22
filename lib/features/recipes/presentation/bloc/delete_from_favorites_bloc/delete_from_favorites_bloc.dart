import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/domain/usecases/delete_from_favorites_usecase.dart';

part 'delete_from_favorites_event.dart';
part 'delete_from_favorites_state.dart';

class DeleteFromFavoritesBloc
    extends Bloc<DeleteFromFavoritesEvent, DeleteFromFavoritesState> {
  DeleteFromFavoritesUsecase deleteFromFavoritesUsecase;
  DeleteFromFavoritesBloc({required this.deleteFromFavoritesUsecase})
      : super(DeleteFromFavoritesInitial()) {
    on<DeleteFromFavoritesEvent>((event, emit) async {
      if (event is DeleteFromFavoriteRecipesEvent) {
        final result =
            await deleteFromFavoritesUsecase.call(event.recipe, event.userId);
        result.fold((failure) => emit(DeleteFromFavoritesError()),
            (unit) => emit(DeleteFromFavoritesSuccess()));
      } else if (event is DeleteFromFavoritesInitialize) {
        emit(DeleteFromFavoritesInitial());
      }
    });
  }
}
