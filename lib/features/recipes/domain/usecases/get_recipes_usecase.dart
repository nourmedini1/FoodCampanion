import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetRecipesUsecase {
  final RecipesRepository recipesRepository;
  GetRecipesUsecase({required this.recipesRepository});
  Future<Either<Failure, FoodTypeList>> call(String type, int no) async {
    return await recipesRepository.getRecipes(type, no);
  }
}
