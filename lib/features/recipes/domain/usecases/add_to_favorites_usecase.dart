import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class AddToFavoritesUsecase {
  final RecipesRepository recipesRepository;
  AddToFavoritesUsecase({required this.recipesRepository});
  Future<Either<Failure, Unit>> call(
      RecipeEntity recipeEntity, String userId) async {
    return await recipesRepository.addToFavotites(recipeEntity, userId);
  }
}
