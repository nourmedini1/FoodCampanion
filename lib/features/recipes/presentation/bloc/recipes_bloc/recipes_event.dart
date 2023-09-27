part of 'recipes_bloc.dart';

sealed class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class RecipesBreakfastEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesBreakfastEvent({required this.query, required this.options});
}

class RecipesDinnerEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesDinnerEvent({required this.query, required this.options});
}

class RecipesBurgerEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesBurgerEvent({required this.query, required this.options});
}

class RecipesCakeEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesCakeEvent({required this.query, required this.options});
}

class RecipesDessertEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesDessertEvent({required this.query, required this.options});
}

class RecipesDrinksEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic>? options;

  const RecipesDrinksEvent({required this.query, required this.options});
}

class RecipesGetFavoritesEvent extends RecipesEvent {
  final String userId;
  const RecipesGetFavoritesEvent({required this.userId});
}

class RecipesAddToFavoritesEvent extends RecipesEvent {
  final RecipeEntity recipeEntity;
  final String userId;

  const RecipesAddToFavoritesEvent(
      {required this.recipeEntity, required this.userId});
}

class RecipesPizzaEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesPizzaEvent({required this.query, required this.options});
}

class RecipesProteinEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesProteinEvent({required this.query, required this.options});
}

class RecipesPopularEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesPopularEvent({required this.query, required this.options});
}

class RecipesRandomEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesRandomEvent({required this.query, required this.options});
}

class RecipesRelatedToCountryEvent extends RecipesEvent {
  final String country;
  final Map<String, dynamic> options;

  const RecipesRelatedToCountryEvent(
      {required this.country, required this.options});
}

class RecipesSearchEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesSearchEvent({required this.query, required this.options});
}

class RecipesVeganEvent extends RecipesEvent {
  final String query;
  final Map<String, dynamic> options;

  const RecipesVeganEvent({required this.query, required this.options});
}
