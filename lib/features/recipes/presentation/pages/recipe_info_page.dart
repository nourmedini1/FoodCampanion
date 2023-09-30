import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';

class RecipeInfo extends StatefulWidget {
  final RecipeEntity item;
  final List<RecipeEntity> similarRecipes;
  const RecipeInfo(
      {super.key, required this.item, required this.similarRecipes});

  @override
  State<RecipeInfo> createState() => _RecipeInfoState();
}

class _RecipeInfoState extends State<RecipeInfo> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
