part of 'recipes_bloc.dart';

sealed class RecipesState extends Equatable {
  const RecipesState();

  @override
  List<Object> get props => [];
}

final class RecipesInitial extends RecipesState {}

class RecipesBreakfastLoadingState extends RecipesState {}

class RecipesBreakfastErrorState extends RecipesState {
  final String errorMessage;

  const RecipesBreakfastErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesBreakfastSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesBreakfastSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesDinnerLoadingState extends RecipesState {}

class RecipesDinnerErrorState extends RecipesState {
  final String errorMessage;

  const RecipesDinnerErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesDinnerSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesDinnerSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesBurgerLoadingState extends RecipesState {}

class RecipesBurgerErrorState extends RecipesState {
  final String errorMessage;

  const RecipesBurgerErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesBurgerSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesBurgerSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesCakeLoadingState extends RecipesState {}

class RecipesCakeErrorState extends RecipesState {
  final String errorMessage;

  const RecipesCakeErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesCakeSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesCakeSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesDessertLoadingState extends RecipesState {}

class RecipesDessertErrorState extends RecipesState {
  final String errorMessage;

  const RecipesDessertErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesDessertSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesDessertSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesDrinksLoadingState extends RecipesState {}

class RecipesDrinksErrorState extends RecipesState {
  final String errorMessage;

  const RecipesDrinksErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesDrinksSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesDrinksSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesAddToFavoritesLoadingState extends RecipesState {}

class RecipesAddToFavoritesErrorState extends RecipesState {
  final String errorMessage;

  const RecipesAddToFavoritesErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesAddToFavoritesSuccesState extends RecipesState {
  final String successMessage;

  const RecipesAddToFavoritesSuccesState({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class RecipesGetFavoritesLoadingState extends RecipesState {}

class RecipesGetFavoritesErrorState extends RecipesState {
  final String errorMessage;

  const RecipesGetFavoritesErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesGetFavoritesSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesGetFavoritesSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesPizzaLoadingState extends RecipesState {}

class RecipesPizzaErrorState extends RecipesState {
  final String errorMessage;

  const RecipesPizzaErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesPizzaSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesPizzaSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesPopularLoadingState extends RecipesState {}

class RecipesPopularErrorState extends RecipesState {
  final String errorMessage;

  const RecipesPopularErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesPopularSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesPopularSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesProteinLoadingState extends RecipesState {}

class RecipesProteinErrorState extends RecipesState {
  final String errorMessage;

  const RecipesProteinErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesProteinSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesProteinSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesRandomLoadingState extends RecipesState {}

class RecipesRandomErrorState extends RecipesState {
  final String errorMessage;

  const RecipesRandomErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesRandomSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesRandomSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesRelatedToCountryLoadingState extends RecipesState {}

class RecipesRelatedToCountryErrorState extends RecipesState {
  final String errorMessage;

  const RecipesRelatedToCountryErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesRelatedToCountrySuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesRelatedToCountrySuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesSearchLoadingState extends RecipesState {}

class RecipesSearchErrorState extends RecipesState {
  final String errorMessage;

  const RecipesSearchErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesSearchSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesSearchSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}

class RecipesVeganLoadingState extends RecipesState {}

class RecipesVeganErrorState extends RecipesState {
  final String errorMessage;

  const RecipesVeganErrorState({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class RecipesVeganSuccesState extends RecipesState {
  final List<RecipeEntity> recipeEntities;

  const RecipesVeganSuccesState({required this.recipeEntities});
  @override
  List<Object> get props => [recipeEntities];
}
