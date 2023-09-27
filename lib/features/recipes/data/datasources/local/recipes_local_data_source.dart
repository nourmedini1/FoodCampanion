import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/recipes/data/models/recipe_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipesLocalDatasource {
  Future<Unit> addToFavorites(RecipeModel recipeModel, String userId);
  Future<List<RecipeModel>> getFavorites(String userId);
}

class RecipesLocalDataSourceImpl extends RecipesLocalDatasource {
  final SharedPreferences sharedPreferences;

  RecipesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> addToFavorites(RecipeModel recipeModel, String userId) {
    try {
      final jsonRecipeModel = json.encode(recipeModel.toJson());
      final List<String>? savedFavorites =
          sharedPreferences.getStringList('$userId-favorites');
      if (savedFavorites == null) {
        sharedPreferences.setStringList('$userId-favorites', [jsonRecipeModel]);
      } else {
        savedFavorites.add(jsonRecipeModel);
        sharedPreferences.setStringList('$userId-favorites', savedFavorites);
      }
      return Future.value(unit);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<RecipeModel>> getFavorites(String userId) {
    final jsonFavorites = sharedPreferences.getStringList('$userId-favorites');
    if (jsonFavorites != null) {
      final List<RecipeModel> favoriteRecipes = jsonFavorites
          .map<RecipeModel>((jsonR) => RecipeModel.fromJson(json.decode(jsonR)))
          .toList();
      return Future.value(favoriteRecipes);
    } else {
      throw DataUNavailableException();
    }
  }
}
