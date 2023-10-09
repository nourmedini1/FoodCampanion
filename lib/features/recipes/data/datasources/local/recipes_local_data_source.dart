import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';

import 'package:shared_preferences/shared_preferences.dart';

abstract class RecipesLocalDatasource {
  Future<Unit> addToFavorites(Recipe recipe, String userId);
  Future<FoodTypeList> getFavorites(String userId);
}

class RecipesLocalDataSourceImpl extends RecipesLocalDatasource {
  final SharedPreferences sharedPreferences;

  RecipesLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> addToFavorites(Recipe recipe, String userId) {
    try {
      FoodType foodType = FoodType(
          id: recipe.id!.toString(),
          name: recipe.title!,
          image: recipe.image!,
          readyInMinutes: recipe.readyInMinutes!.toString(),
          servings: recipe.servings!.toString());
      final jsonFoodType = json.encode(foodType.toJson());
      final List<String>? savedFavorites =
          sharedPreferences.getStringList('$userId-favorites');
      if (savedFavorites == null) {
        sharedPreferences.setStringList('$userId-favorites', [jsonFoodType]);
      } else {
        savedFavorites.add(jsonFoodType);
        sharedPreferences.setStringList('$userId-favorites', savedFavorites);
      }
      return Future.value(unit);
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<FoodTypeList> getFavorites(String userId) {
    final jsonFavorites = sharedPreferences.getStringList('$userId-favorites');
    if (jsonFavorites != null) {
      List<Map<String, dynamic>> fav = jsonFavorites
          .map<Map<String, dynamic>>((e) => json.decode(e))
          .toList();
      final FoodTypeList favoriteRecipes = FoodTypeList.fromJson(fav);

      return Future.value(favoriteRecipes);
    } else {
      throw DataUNavailableException();
    }
  }
}
