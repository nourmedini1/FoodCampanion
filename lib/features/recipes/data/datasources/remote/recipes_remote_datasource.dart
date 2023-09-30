import 'package:dio/dio.dart';

import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/recipes/data/models/auto_complete.dart';
import 'package:food_campanion/features/recipes/data/models/equipement.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/data/models/nutrients.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/search_results.dart';

import 'package:food_campanion/features/recipes/data/models/similar_list.dart';
import 'package:food_campanion/features/recipes/utils/strings/strings.dart';

abstract class RecipesRemoteDataSource {
  Future<List<dynamic>> getRecipeInfo(String id);
  Future<SearchResultList> getSearchList(String type, int no);
  Future<SearchAutoCompleteList> getAutoCompleteList(String searchText);
  Future<FoodTypeList> getRecipes(String type, int no);
}

class RecipesRemoteDatasourceImpl extends RecipesRemoteDataSource {
  final Dio dio;

  RecipesRemoteDatasourceImpl({required this.dio});
  @override
  Future<FoodTypeList> getRecipes(String type, int no) async {
    // ignore: prefer_interpolation_to_compose_strings
    var url = BASE_URL + "/random?number=$no&tags=$type" + '&apiKey=' + API_KEY;
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      return FoodTypeList.fromJson(response.data['recipes']);
    } else if (response.statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
  }

  @override
  Future<List<dynamic>> getRecipeInfo(String id) async {
    var infoUrl = '$BASE_URL$id$INFORMATION_PATH&apiKey=$API_KEY';
    var similarUrl = '$BASE_URL$id$SIMILAR_PATH&apiKey=$API_KEY';
    var equipmentUrl = '$BASE_URL$id$EQUIPMENTS_PATH&apiKey=$API_KEY';
    var nutritionUrl = '$BASE_URL$id$NUTRITION_PATH&apiKey=$API_KEY';

    Recipe racipeInfo;
    SimilarList similarList;
    EquipmentsList equipmentList;
    Nutrient nutrients;
    final response = await Future.wait([
      dio.get(infoUrl),
      dio.get(similarUrl),
      dio.get(equipmentUrl),
      dio.get(nutritionUrl),
    ]);
    if (response[0].statusCode == 200) {
      racipeInfo = Recipe.fromJson(response[0].data);
    } else if (response[0].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[1].statusCode == 200) {
      similarList = SimilarList.fromJson(response[1].data);
    } else if (response[1].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[2].statusCode == 200) {
      equipmentList = EquipmentsList.fromJson(response[2].data['equipment']);
    } else if (response[2].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[3].statusCode == 200) {
      nutrients = Nutrient.fromJson(response[3].data);
    } else if (response[3].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }

    return [
      racipeInfo,
      similarList,
      equipmentList,
      nutrients,
    ];
  }

  @override
  Future<SearchResultList> getSearchList(String type, int no) async {
    var url =
        'https://api.spoonacular.com/recipes/complexSearch?query=$type&number=$no&apiKey=${API_KEY}';

    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return SearchResultList.fromJson(response.data['results']);
    } else if (response.statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
  }

  @override
  Future<SearchAutoCompleteList> getAutoCompleteList(String searchText) async {
    var url =
        'https://api.spoonacular.com/recipes/autocomplete?number=100&query=$searchText&apiKey=${API_KEY}';
    var response = await dio.get(url);

    if (response.statusCode == 200) {
      return SearchAutoCompleteList.fromJson(response.data);
    } else if (response.statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
  }
}
