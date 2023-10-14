import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/core/network/internet_checker.dart';
import 'package:food_campanion/features/recipes/data/datasources/local/recipes_local_data_source.dart';
import 'package:food_campanion/features/recipes/data/datasources/remote/recipes_remote_datasource.dart';
import 'package:food_campanion/features/recipes/data/models/auto_complete.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/search_results.dart';
import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';

class RecipesRepositoryImpl extends RecipesRepository {
  final RecipesRemoteDataSource recipesRemoteDataSource;
  final InternetChecker internetChecker;
  final RecipesLocalDatasource recipesLocalDatasource;

  RecipesRepositoryImpl(
      {required this.recipesLocalDatasource,
      required this.recipesRemoteDataSource,
      required this.internetChecker});

  @override
  Future<Either<Failure, Unit>> addToFavorites(
      Recipe recipe, String userId) async {
    try {
      await recipesLocalDatasource.addToFavorites(recipe, userId);
      return right(unit);
    } on DataUNavailableException {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, SearchAutoCompleteList>> getAutoCompleteList(
      String searchText) async {
    if (await internetChecker.isConnected) {
      try {
        final result =
            await recipesRemoteDataSource.getAutoCompleteList(searchText);
        return Right(result);
      } on DataUNavailableException {
        return Left(DataUnavailableFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, FoodTypeList>> getFavorites(String userId) async {
    try {
      final result = await recipesLocalDatasource.getFavorites(userId);
      return Right(result);
    } on DataUNavailableException {
      return left(Failure());
    }
  }

  @override
  Future<Either<Failure, List>> getRandomRecipe() async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipe();
        return Right(result);
      } on DataUNavailableException {
        return Left(DataUnavailableFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List>> getRecipeInfo(String id) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipeInfo(id);
        return Right(result);
      } on DataUNavailableException {
        return Left(DataUnavailableFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, FoodTypeList>> getRecipes(String type, int no) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(type, no);
        return Right(result);
      } on DataUNavailableException {
        return Left(DataUnavailableFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, SearchResultList>> getSearchResults(
      String type, int no) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getSearchList(type, no);
        return Right(result);
      } on DataUNavailableException {
        return Left(DataUnavailableFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteFromFavorites(
      Recipe recipe, String userId) async {
    try {
      await recipesLocalDatasource.deleteFromFavorites(recipe, userId);
      return right(unit);
    } on DataUNavailableException {
      return left(Failure());
    }
  }
}
