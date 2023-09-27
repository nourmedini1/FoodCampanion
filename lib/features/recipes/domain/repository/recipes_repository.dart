import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';

abstract class RecipesRepository {
  Future<Either<Failure, List<RecipeEntity>>> searchRecipe(
      String query, Map<String, dynamic> options);

  Future<Either<Failure, List<RecipeEntity>>> breakfastRecipes(String query);

  Future<Either<Failure, Unit>> addToFavotites(
      RecipeEntity recipeEntity, String userId);

  Future<Either<Failure, List<RecipeEntity>>> getFavorites(String userId);

  Future<Either<Failure, List<RecipeEntity>>> dinnerRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> pizzaRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> cakeRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> burgerRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> drinksRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> randomRecipe(
      String query, Map<String, dynamic> options);

  Future<Either<Failure, List<RecipeEntity>>> veganRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> dessertRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> proteinRecipes(String query);

  Future<Either<Failure, List<RecipeEntity>>> popularRecipes(String query);
  Future<Either<Failure, List<RecipeEntity>>> relatedToCountryRecipes(
      String country);
}
