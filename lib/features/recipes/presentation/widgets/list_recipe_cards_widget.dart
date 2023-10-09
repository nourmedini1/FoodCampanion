import 'package:flutter/material.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/recipe_card_widget.dart';

class CardsListWidget extends StatelessWidget {
  final List<dynamic> items;

  const CardsListWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 280,
        child: ListView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          // store this controller in a State to save the carousel scroll position
          children: [
            const SizedBox(width: 20),
            ...items.map((item) {
              return RecipeCardWidget(items: item);
            }).toList()
          ],
        ));
  }
}
