import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/domain/entities/recipe_entity.dart';

Widget ingredientItem(Ingredient ingredient) {
  return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.20),
                )
              ],
              shape: BoxShape.circle,
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: CachedNetworkImageProvider(ingredient.image!)),
            ))
      ]));
}
