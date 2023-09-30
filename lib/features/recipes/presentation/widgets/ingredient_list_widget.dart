import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/ingredient_item.dart';

Widget ingredientListWidget(List<Ingredient> ingredients) {
  List<Widget> list =
      ingredients.map((ingredient) => ingredientItem(ingredient)).toList();
  list.insert(
      0,
      const SizedBox(
        width: 26,
      ));
  list.add(const SizedBox(
    width: 26,
  ));
  return SizedBox(
      height: 170,
      child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: list));
}
