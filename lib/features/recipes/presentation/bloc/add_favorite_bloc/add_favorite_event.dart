part of 'add_favorite_bloc.dart';

sealed class AddFavoriteEvent extends Equatable {
  const AddFavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteInitialize extends AddFavoriteEvent {}

class AddFavoriteRecipeEvent extends AddFavoriteEvent {
  final Recipe recipe;
  final String userId;

  const AddFavoriteRecipeEvent({required this.recipe, required this.userId});

  @override
  List<Object> get props => [recipe, userId];
}
