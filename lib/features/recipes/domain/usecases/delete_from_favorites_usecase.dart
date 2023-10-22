import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class DeleteFromFavoritesUsecase {
  final RecipesRepository recipesRepository;
  DeleteFromFavoritesUsecase({required this.recipesRepository});
  Future<Either<Failure, Unit>> call(FoodType recipe, String userId) async {
    return await recipesRepository.deleteFromFavorites(recipe, userId);
  }
}
