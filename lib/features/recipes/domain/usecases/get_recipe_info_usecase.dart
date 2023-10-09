import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetRecipeInfoUsecase {
  final RecipesRepository recipesRepository;
  GetRecipeInfoUsecase({required this.recipesRepository});
  Future<Either<Failure, List<dynamic>>> call(String id) async {
    return await recipesRepository.getRecipeInfo(id);
  }
}
