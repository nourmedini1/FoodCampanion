import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/auto_complete.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/search_results.dart';

abstract class RecipesRepository {
  Future<Either<Failure, Unit>> addToFavorites(Recipe recipe, String userId);
  Future<Either<Failure, Unit>> deleteFromFavorites(
      FoodType recipe, String userId);
  Future<Either<Failure, FoodTypeList>> getFavorites(String userId);
  Future<Either<Failure, FoodTypeList>> getRecipes(String type, int no);
  Future<Either<Failure, List<dynamic>>> getRandomRecipe();
  Future<Either<Failure, List<dynamic>>> getRecipeInfo(String id);
  Future<Either<Failure, SearchResultList>> getSearchResults(
      String type, int no);
  Future<Either<Failure, SearchAutoCompleteList>> getAutoCompleteList(
      String searchText);
}
