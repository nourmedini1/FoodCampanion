import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/data/models/extended_ingredient.dart';

Widget ingredientItem(ExtendedIngredient ingredient) {
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
                  image: CachedNetworkImageProvider(
                      "https://spoonacular.com/cdn/ingredients_500x500/${ingredient.image!}")),
            )),
        Container(
          width: 100,
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              ingredient.name!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ]));
}
