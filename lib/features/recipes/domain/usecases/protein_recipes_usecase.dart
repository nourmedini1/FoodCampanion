import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class ProteinRecipesUsecase {
  final RecipesRepository recipesRepository;
  ProteinRecipesUsecase({required this.recipesRepository});
  Future<Either<Failure, List<RecipeEntity>>> call(String query) async {
    return await recipesRepository.proteinRecipes(query);
  }
}
