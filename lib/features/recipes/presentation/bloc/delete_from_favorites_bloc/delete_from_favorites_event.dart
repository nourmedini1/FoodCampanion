part of 'delete_from_favorites_bloc.dart';

sealed class DeleteFromFavoritesEvent extends Equatable {
  const DeleteFromFavoritesEvent();

  @override
  List<Object> get props => [];
}

class DeleteFromFavoritesInitialize extends DeleteFromFavoritesEvent {}

class DeleteFromFavoriteRecipesEvent extends DeleteFromFavoritesEvent {
  final FoodType recipe;
  final String userId;

  const DeleteFromFavoriteRecipesEvent(
      {required this.recipe, required this.userId});

  @override
  List<Object> get props => [recipe, userId];
}
