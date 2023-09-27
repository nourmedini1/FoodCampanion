import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
import 'package:food_campanion/features/recipes/domain/usecases/add_to_favorites_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/breakfast_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/burger_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/cake_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/dessert_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/dinner_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/drinks_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_favorites_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/pizza_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/popular_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/protein_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/random_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/related_to_country_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/search_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/vegan_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/utils/strings/strings.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final CakeRecipesUsecase cakeRecipesUsecase;
  final AddToFavoritesUsecase addToFavoritesUsecase;
  final BreakfastRecipesUsecase breakfastRecipesUsecase;
  final BurgerRecipesUsecase burgerRecipesUsecase;
  final DessertRecipesUsecase dessertRecipesUsecase;
  final DinnerRecipesUsecase dinnerRecipesUsecase;
  final DrinksRecipesUsecase drinksRecipesUsecase;
  final GetFavoritesUsecase getFavoritesUsecase;
  final PizzaRecipesUsecase pizzaRecipesUsecase;
  final PopularRecipesUsecase popularRecipesUsecase;
  final ProteinRecipesUsecase proteinRecipesUsecase;
  final RandomRecipeUsecase randomRecipeUsecase;
  final RelatedToCountryRecipesUsecase relatedToCountryRecipesUsecase;
  final SearchRecipeUsecase searchRecipeUsecase;
  final VeganRecipesUsecase veganRecipesUsecase;

  RecipesBloc(
      {required this.addToFavoritesUsecase,
      required this.cakeRecipesUsecase,
      required this.breakfastRecipesUsecase,
      required this.burgerRecipesUsecase,
      required this.dessertRecipesUsecase,
      required this.dinnerRecipesUsecase,
      required this.drinksRecipesUsecase,
      required this.getFavoritesUsecase,
      required this.pizzaRecipesUsecase,
      required this.popularRecipesUsecase,
      required this.proteinRecipesUsecase,
      required this.randomRecipeUsecase,
      required this.relatedToCountryRecipesUsecase,
      required this.searchRecipeUsecase,
      required this.veganRecipesUsecase})
      : super(RecipesInitial()) {
    on<RecipesEvent>((event, emit) async {
      if (event is RecipesBreakfastEvent) {
        emit(RecipesBreakfastLoadingState());
        final result = await breakfastRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesBreakfastErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesBreakfastSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesAddToFavoritesEvent) {
        emit(RecipesAddToFavoritesLoadingState());
        final result =
            await addToFavoritesUsecase.call(event.recipeEntity, event.userId);
        result.fold(
            (failure) => emit(const RecipesAddToFavoritesErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (unit) => emit(const RecipesAddToFavoritesSuccesState(
                successMessage: 'Added to your favorites')));
      } else if (event is RecipesBurgerEvent) {
        emit(RecipesBurgerLoadingState());
        final result = await burgerRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesBurgerErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesBurgerSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesCakeEvent) {
        emit(RecipesCakeLoadingState());
        final result = await cakeRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesCakeErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) => emit(RecipesCakeSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesDessertEvent) {
        emit(RecipesDessertLoadingState());
        final result = await dessertRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesDessertErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesDessertSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesDinnerEvent) {
        emit(RecipesDinnerLoadingState());
        final result = await dinnerRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesDinnerErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesDinnerSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesDrinksEvent) {
        emit(RecipesDrinksLoadingState());
        final result = await drinksRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesDrinksErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesDrinksSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesPizzaEvent) {
        emit(RecipesPizzaLoadingState());
        final result = await pizzaRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesPizzaErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesPizzaSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesProteinEvent) {
        emit(RecipesProteinLoadingState());
        final result = await proteinRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesProteinErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesProteinSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesRelatedToCountryEvent) {
        emit(RecipesRelatedToCountryLoadingState());
        final result = await relatedToCountryRecipesUsecase.call(event.country);
        result.fold(
            (failure) => emit(const RecipesRelatedToCountryErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) => emit(
                RecipesRelatedToCountrySuccesState(recipeEntities: recipes)));
      } else if (event is RecipesRandomEvent) {
        emit(RecipesRandomLoadingState());
        final result =
            await randomRecipeUsecase.call(event.query, event.options);
        result.fold(
            (failure) => emit(const RecipesRandomErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesRandomSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesPopularEvent) {
        emit(RecipesPopularLoadingState());
        final result = await popularRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesPopularErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesPopularSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesSearchEvent) {
        emit(RecipesSearchLoadingState());
        final result =
            await searchRecipeUsecase.call(event.query, event.options);
        result.fold(
            (failure) => emit(const RecipesSearchErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesSearchSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesVeganEvent) {
        emit(RecipesVeganLoadingState());
        final result = await veganRecipesUsecase.call(event.query);
        result.fold(
            (failure) => emit(const RecipesSearchErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesSearchSuccesState(recipeEntities: recipes)));
      } else if (event is RecipesGetFavoritesEvent) {
        emit(RecipesGetFavoritesLoadingState());
        final result = await getFavoritesUsecase.call(event.userId);
        result.fold(
            (failure) => emit(const RecipesGetFavoritesErrorState(
                errorMessage: DATA_UNAVAILABLE_ERROR_MESSAGE)),
            (recipes) =>
                emit(RecipesGetFavoritesSuccesState(recipeEntities: recipes)));
      }
    });
  }
}
