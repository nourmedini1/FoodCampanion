import 'dart:convert';

import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/recipes/data/models/recipe_model.dart';
import 'package:http/http.dart' as http;

abstract class RecipesRemoteDataSource {
  Future<List<RecipeModel>> getRecipes(
      String query, Map<String, dynamic>? options);
}

class RecipesRemoteDatasourceImpl extends RecipesRemoteDataSource {
  final http.Client client;
  final app_id = 'abc6250a';
  final app_key = '752c99c9eca093efafd805b9e6b61122';
  final BASE_URL = 'https://api.edamam.com/api/recipes/v2?type=public';

  RecipesRemoteDatasourceImpl({required this.client});
  @override
  Future<List<RecipeModel>> getRecipes(
      String query, Map<String, dynamic>? options) async {
    String url = '';
    final appCredintials = '&app_id=$app_id&app_key=$app_key';
    final q = '&q=$query';
    const random = '&random=true';

    if (options != null) {
      String optionsString = '';
      for (var element in options.keys) {
        if (options[element] != "") {
          optionsString = '$optionsString&$element=${options[element]}';
        }
      }
      url = '$BASE_URL$q$appCredintials$optionsString$random';
    } else {
      url = '$BASE_URL$q$appCredintials$random';
    }

    final response = await client
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);
      final List<Map<String, dynamic>> recipesJson = body['hits'];
      final List<RecipeModel> recipes = recipesJson
          .map<RecipeModel>((json) => RecipeModel.fromJson(json))
          .toList();
      return Future.value(recipes);
    } else {
      throw DataUNavailableException();
    }
  }
}
