import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class AddToFavoritesUsecase {
  final RecipesRepository recipesRepository;
  AddToFavoritesUsecase({required this.recipesRepository});
  Future<Either<Failure, Unit>> call(Recipe recipe, String userId) async {
    return await recipesRepository.addToFavorites(recipe, userId);
  }
}
