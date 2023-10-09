part of 'recipe_info_bloc.dart';

sealed class RecipeInfoEvent extends Equatable {
  const RecipeInfoEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipeInfo extends RecipeInfoEvent {
  final String id;

  const LoadRecipeInfo(this.id);
  @override
  List<Object> get props => [id];
}
