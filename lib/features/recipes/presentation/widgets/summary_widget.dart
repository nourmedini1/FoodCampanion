import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

Widget summaryWidget(RecipeEntity recipeEntity) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: const [
        BoxShadow(
          offset: Offset(-2, -2),
          blurRadius: 12,
          color: Color.fromRGBO(0, 0, 0, 0.05),
        ),
        BoxShadow(
          offset: Offset(2, 2),
          blurRadius: 5,
          color: Color.fromRGBO(0, 0, 0, 0.10),
        )
      ],
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Text('${recipeEntity.totalTime} min',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(
                "Ready in",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 30,
          width: 2,
          color: orange,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Text(recipeEntity.recipeYield.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text(
                "Servings",
                style: TextStyle(color: Colors.grey.shade600),
              )
            ],
          ),
        ),
        Container(
          height: 30,
          width: 2,
          color: orange,
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: [
              Text(recipeEntity.calories.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              Text("Calories", style: TextStyle(color: Colors.grey.shade600))
            ],
          ),
        )
      ],
    ),
  );
}
