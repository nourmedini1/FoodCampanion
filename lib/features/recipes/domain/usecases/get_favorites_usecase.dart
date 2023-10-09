import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetFavoritesUsecase {
  final RecipesRepository recipesRepository;
  GetFavoritesUsecase({required this.recipesRepository});
  Future<Either<Failure, FoodTypeList>> call(String userId) async {
    return await recipesRepository.getFavorites(userId);
  }
}
