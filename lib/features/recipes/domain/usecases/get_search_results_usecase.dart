import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/search_results.dart';

import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class GetSearchResultsUsecase {
  final RecipesRepository recipesRepository;
  GetSearchResultsUsecase({required this.recipesRepository});
  Future<Either<Failure, SearchResultList>> call(String type, no) async {
    return await recipesRepository.getSearchResults(type, no);
  }
}
