import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/favorite_item.dart';

class FavoritesWidget extends StatelessWidget {
  final List<FoodType> favorites;
  final String userId;

  const FavoritesWidget(
      {super.key, required this.favorites, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView.builder(
                itemBuilder: (context, i) {
                  final info = favorites[i];

                  return FavoriteItem(
                    meal: info,
                    userId: userId,
                  );
                },
                itemCount: favorites.length)));
  }
}
