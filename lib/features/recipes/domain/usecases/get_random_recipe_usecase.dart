import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetRandomRecipeUsecase {
  final RecipesRepository recipesRepository;
  GetRandomRecipeUsecase({required this.recipesRepository});
  Future<Either<Failure, List<dynamic>>> call() async {
    return await recipesRepository.getRandomRecipe();
  }
}
