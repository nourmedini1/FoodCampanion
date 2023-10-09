import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/auto_complete.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetAutoCompleteListUsecase {
  final RecipesRepository recipesRepository;
  GetAutoCompleteListUsecase({required this.recipesRepository});
  Future<Either<Failure, SearchAutoCompleteList>> call(
      String searchText) async {
    return await recipesRepository.getAutoCompleteList(searchText);
  }
}
