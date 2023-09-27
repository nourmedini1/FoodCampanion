import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/core/network/internet_checker.dart';
import 'package:food_campanion/features/recipes/data/datasources/local/recipes_local_data_source.dart';
import 'package:food_campanion/features/recipes/data/datasources/remote/recipes_remote_datasource.dart';
import 'package:food_campanion/features/recipes/data/models/recipe_model.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
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
  Future<Either<Failure, List<RecipeEntity>>> breakfastRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> burgerRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> cakeRecipes(String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> dessertRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> dinnerRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> drinksRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> pizzaRecipes(String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> popularRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> proteinRecipes(
      String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> randomRecipe(
      String query, Map<String, dynamic> options) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, options);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> relatedToCountryRecipes(
      String country) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(country, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipe(
      String query, Map<String, dynamic> options) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, options);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> veganRecipes(String query) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesRemoteDataSource.getRecipes(query, null);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addToFavotites(
      RecipeEntity recipeEntity, String userId) async {
    if (await internetChecker.isConnected) {
      try {
        await recipesLocalDatasource.addToFavorites(
            RecipeModel.fromEntity(recipeEntity), userId);
        return right(unit);
      } catch (e) {
        return left(Failure());
      }
    } else {
      return left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getFavorites(
      String userId) async {
    if (await internetChecker.isConnected) {
      try {
        final result = await recipesLocalDatasource.getFavorites(userId);
        return right(result);
      } on DataUNavailableException {
        return left(DataUnavailableFailure());
      }
    } else {
      return left(OfflineFailure());
    }
  }
}
