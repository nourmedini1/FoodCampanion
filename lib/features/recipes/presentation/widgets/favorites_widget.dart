import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/horizontal_recipe_card_widget.dart';

class FavoritesWidget extends StatelessWidget {
  final List<FoodType> favorites;

  const FavoritesWidget({super.key, required this.favorites});
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView.builder(
                itemBuilder: (context, i) {
                  final info = favorites[i];

                  return ListItem(meal: info);
                },
                itemCount: favorites.length)));
  }
}
