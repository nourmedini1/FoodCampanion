import 'dart:convert';

import 'package:http/http.dart' as http;
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
  Future<List<dynamic>> getRecipe();
}

class RecipesRemoteDatasourceImpl extends RecipesRemoteDataSource {
  final http.Client client;

  RecipesRemoteDatasourceImpl({required this.client});

  @override
  Future<List<dynamic>> getRecipe() async {
    var infoUrl = '$BASE_URL$RANDOM_RACIPE_PATH&apiKey=$API_KEY';
    var id = '';

    Recipe racipeInfo;
    SimilarList similarList;
    EquipmentsList equipmentList;
    Nutrient nutrients;

    final res = await client.get(Uri.parse(infoUrl));

    if (res.statusCode == 200) {
      final body = json.decode(res.body);
      racipeInfo = Recipe.fromJson(body['recipes'][0]);
      id = body['recipes'][0]['id'].toString();
    } else if (res.statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }

    var similarUrl = '$BASE_URL$id$SIMILAR_PATH&apiKey=$API_KEY';
    var equipmentUrl = '$BASE_URL$id$EQUIPMENTS_PATH&apiKey=$API_KEY';
    var nutritionUrl = '$BASE_URL$id$NUTRITION_PATH&apiKey=$API_KEY';

    final response = await Future.wait([
      client.get(Uri.parse(similarUrl)),
      client.get(Uri.parse(equipmentUrl)),
      client.get(Uri.parse(nutritionUrl))
    ]);

    if (response[0].statusCode == 200) {
      final similarbody = json.decode(response[0].body);
      similarList = SimilarList.fromJson(similarbody);
    } else if (response[0].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[1].statusCode == 200) {
      final equipementbody = json.decode(response[1].body);
      equipmentList = EquipmentsList.fromJson(equipementbody['equipement']);
    } else if (response[1].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[2].statusCode == 200) {
      final nutrientBody = json.decode(response[2].body);
      nutrients = Nutrient.fromJson(nutrientBody);
    } else if (response[2].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }

    return Future.value([
      racipeInfo,
      similarList,
      equipmentList,
      nutrients,
    ]);
  }

  @override
  Future<FoodTypeList> getRecipes(String type, int no) async {
    var url = '${BASE_URL}random?number=$no&tags=$type&apiKey=$API_KEY';
    final response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> tt = body['recipes'];
      return Future.value(FoodTypeList.fromJson(tt));
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
      client.get(Uri.parse(infoUrl)),
      client.get(Uri.parse(similarUrl)),
      client.get(Uri.parse(equipmentUrl)),
      client.get(Uri.parse(nutritionUrl))
    ]);
    if (response[0].statusCode == 200) {
      racipeInfo = Recipe.fromJson(json.decode(response[0].body));
    } else if (response[0].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[1].statusCode == 200) {
      similarList = SimilarList.fromJson(json.decode(response[1].body));
    } else if (response[1].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[2].statusCode == 200) {
      equipmentList =
          EquipmentsList.fromJson(json.decode(response[2].body)['equipment']);
    } else if (response[2].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
    if (response[3].statusCode == 200) {
      nutrients = Nutrient.fromJson(json.decode(response[3].body));
    } else if (response[3].statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }

    return Future.value([
      racipeInfo,
      similarList,
      equipmentList,
      nutrients,
    ]);
  }

  @override
  Future<SearchResultList> getSearchList(String type, int no) async {
    var url =
        'https://api.spoonacular.com/recipes/complexSearch?query=$type&number=$no&apiKey=${API_KEY}';

    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Future.value(
          SearchResultList.fromJson(json.decode(response.body)['results']));
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
    var response = await client.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Future.value(
          SearchAutoCompleteList.fromJson(json.decode(response.body)));
    } else if (response.statusCode == 401) {
      throw DataUNavailableException();
    } else {
      throw DataUNavailableException();
    }
  }
}
