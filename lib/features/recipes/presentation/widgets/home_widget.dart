import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/domain/entities/category_entity.dart';
import 'package:food_campanion/features/recipes/domain/entities/event_entity.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_result_bloc/search_result_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/search_results.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/events_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/horizontal_recipe_card_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/list_recipe_cards_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/suggestion_widget.dart';

class HomeScreenWidget extends StatefulWidget {
  final List<FoodType> breakfast;
  final List<FoodType> vegan;
  final List<FoodType> drinks;
  final List<FoodType> burgers;
  final List<FoodType> pizza;
  final List<FoodType> cake;
  final List<FoodType> soup;
  final List<FoodType> salad;
  const HomeScreenWidget({
    super.key,
    required this.breakfast,
    required this.vegan,
    required this.drinks,
    required this.burgers,
    required this.pizza,
    required this.cake,
    required this.soup,
    required this.salad,
  });

  @override
  _HomeScreenWidgetState createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DelayedDisplay(
              delay: Duration(microseconds: 600),
              child: Text(
                "Simple Way to find \nTasty food",
                style: TextStyle(
                  fontFamily: 'mooli',
                  fontWeight: FontWeight.bold,
                  color: Colors.amber,
                  fontSize: 30,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          DelayedDisplay(
            delay: const Duration(milliseconds: 600),
            child: header("Recommended Categories", "Categories"),
          ),
          const SizedBox(height: 20),
          DelayedDisplay(
            delay: const Duration(milliseconds: 600),
            child: suggestions(CategoryEntity.getCategories()),
          ),
          const SizedBox(height: 10),
          DelayedDisplay(
            delay: const Duration(milliseconds: 600),
            child: header("Recipes For Your events", "Events"),
          ),
          const SizedBox(height: 20),
          DelayedDisplay(
            delay: const Duration(milliseconds: 600),
            child: events(EventEntity.getEvents()),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: header("Popular Breakfast Recipes", "breakfast"),
          ),
          const SizedBox(height: 10),
          DelayedDisplay(
            delay: const Duration(microseconds: 600),
            child: CardsListWidget(
              items: widget.breakfast,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Best Vegan Recipes", "vegan"),
                ...widget.vegan.map((meal) {
                  return ListItem(
                    meal: meal,
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: header("Popular Drinks", "drinks"),
          ),
          const SizedBox(height: 10),
          CardsListWidget(items: widget.drinks),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Best burger Recipes", "burgers"),
                ...widget.burgers.map((meal) {
                  return ListItem(
                    meal: meal,
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: header("pizza", "pizza"),
          ),
          const SizedBox(height: 10),
          CardsListWidget(items: widget.pizza),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header("Want the best cake ?", "cake"),
                ...widget.cake.map((meal) {
                  return ListItem(
                    meal: meal,
                  );
                }).toList(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: header("Soups from all over the world", "soup"),
                ),
                const SizedBox(height: 10),
                CardsListWidget(items: widget.soup),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: header("Salads", "salad"),
                ),
                const SizedBox(height: 10),
                CardsListWidget(items: widget.salad),
              ],
            ),
          ),
        ],
      ),
    );
  }

  header(String name, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DelayedDisplay(
            delay: const Duration(microseconds: 600),
            child: Text(name,
                style: const TextStyle(
                  fontFamily: 'acme',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<SearchResultBloc>(),
                      child: SearchResults(
                        id: title,
                      ),
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_forward_sharp))
        ],
      ),
    );
  }
}
