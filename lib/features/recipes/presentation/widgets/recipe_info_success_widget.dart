import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/data/models/equipement.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/data/models/nutrients.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/similar_list.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/appbar.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/equipments.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/ingredient_list_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/list_recipe_cards_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/nutrirents.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/summary_widget.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';
import 'package:food_campanion/features/users/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RacipeInfoWidget extends StatefulWidget {
  late bool liked = false;
  final Recipe info;

  final List<Similar> similarlist;
  final List<Equipment> equipment;
  final Nutrient nutrient;
  late String? id = '';
  List<FoodType> favorites = [];
  SharedPreferences sharedPreferences = sl<SharedPreferences>();

  RacipeInfoWidget({
    Key? key,
    required this.info,
    required this.similarlist,
    required this.equipment,
    required this.nutrient,
  }) : super(key: key);

  @override
  State<RacipeInfoWidget> createState() => _RacipeInfoWidgetState();
}

class _RacipeInfoWidgetState extends State<RacipeInfoWidget> {
  @override
  void initState() {
    super.initState();
    FoodType meal = FoodType(
        id: widget.info.id.toString(),
        name: widget.info.title!,
        image: widget.info.image!,
        readyInMinutes: widget.info.readyInMinutes.toString(),
        servings: widget.info.servings.toString());
    widget.id = UserModel.fromJson(
            json.decode(widget.sharedPreferences.getString('CURRENT_USER')!))
        .id;

    final jsonFavorites =
        widget.sharedPreferences.getStringList('$widget.id-favorites');
    if (jsonFavorites != null) {
      List<Map<String, dynamic>> fav = jsonFavorites
          .map<Map<String, dynamic>>((e) => json.decode(e))
          .toList();
      final FoodTypeList favoriteRecipes = FoodTypeList.fromJson(fav);
      widget.favorites = favoriteRecipes.list;
      widget.liked =
          widget.favorites.isEmpty || !widget.favorites.contains(meal);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 300, info: widget.info),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DelayedDisplay(
                    delay: const Duration(microseconds: 600),
                    child: Container(
                      padding: const EdgeInsets.all(26.0),
                      child: Text(
                        widget.info.title!,
                        style: const TextStyle(
                            fontFamily: 'mooli',
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26.0, vertical: 10),
                    child: DelayedDisplay(
                        delay: const Duration(microseconds: 700),
                        child: summaryWidget(widget.info)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(26),
                    child: BlocConsumer<AddFavoriteBloc, AddFavoriteState>(
                      listener: (context, state) {
                        if (state is AddFavoriteError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              dismissDirection: DismissDirection.up,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 150,
                                  left: 10,
                                  right: 10),
                              duration: const Duration(seconds: 3),
                              content: const Text(
                                'Failed to add to favorites',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )));
                        } else if (state is AddFavoriteSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.lightGreen,
                              dismissDirection: DismissDirection.up,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).size.height - 150,
                                  left: 10,
                                  right: 10),
                              duration: const Duration(seconds: 3),
                              content: const Text(
                                'Added succesfully',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )));
                        }
                      },
                      builder: (context, state) {
                        if (state is AddFavoriteLoading) {
                          return const LoadingWidget();
                        } else if (state is AddFavoriteSuccess) {
                          BlocProvider.of<AddFavoriteBloc>(context)
                              .add(AddFavoriteInitialize());
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FavoriteButtonWidget(
                                  widget: widget, text: 'added to favorites'),
                            ],
                          );
                        } else if (state is AddFavoriteError) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [addToFavoritesButton(widget.id)],
                          );
                        } else {
                          return DelayedDisplay(
                            delay: const Duration(milliseconds: 600),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                !widget.liked
                                    ? addToFavoritesButton(widget.id)
                                    : FavoriteButtonWidget(
                                        widget: widget,
                                        text: 'added to favorites'),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(26.0),
                    child: DelayedDisplay(
                      delay: Duration(microseconds: 700),
                      child: Text(
                        "Ingredients",
                        style: TextStyle(
                            fontFamily: 'mooli',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                  if (widget.info.extendedIngredients!.isNotEmpty)
                    DelayedDisplay(
                      delay: const Duration(microseconds: 600),
                      child: ingredientListWidget(
                        widget.info.extendedIngredients!,
                      ),
                    ),
                  if (widget.info.instructions != null)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Instructions",
                            style: TextStyle(
                              fontFamily: 'mooli',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.info.instructions!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'mooli',
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  if (widget.equipment.isNotEmpty)
                    const Padding(
                      padding: EdgeInsets.all(26.0),
                      child: Text(
                        "Equipments",
                        style: TextStyle(
                            fontFamily: 'mooli',
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  if (widget.equipment.isNotEmpty)
                    EquipmentsListView(
                      equipments: widget.equipment,
                    ),
                  if (widget.info.summary != null)
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Quick summary",
                            style: TextStyle(
                              fontFamily: 'mooli',
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.info.summary!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: 'mooli',
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                  NutrientsWidgets(
                    nutrient: widget.nutrient,
                  ),
                  NutrientsbadWidget(
                    nutrient: widget.nutrient,
                  ),
                  NutrientsgoodWidget(
                    nutrient: widget.nutrient,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (widget.similarlist.isNotEmpty)
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30.0, vertical: 26),
                      child: Text("Similar items",
                          style: TextStyle(
                              fontFamily: 'mooli',
                              fontWeight: FontWeight.bold,
                              fontSize: 22)),
                    ),
                  if (widget.similarlist.isNotEmpty)
                    CardsListWidget(items: widget.similarlist),
                  const SizedBox(
                    height: 40,
                  ),
                ]),
          )
        ],
      ),
    );
  }

  GestureDetector addToFavoritesButton(String? userId) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.liked = !widget.liked;
        });

        BlocProvider.of<AddFavoriteBloc>(context)
            .add(AddFavoriteRecipeEvent(recipe: widget.info, userId: userId!));
      },
      child: FavoriteButtonWidget(widget: widget, text: 'add to favorites'),
    );
  }
}

class FavoriteButtonWidget extends StatelessWidget {
  const FavoriteButtonWidget(
      {super.key, required this.widget, required this.text});

  final RacipeInfoWidget widget;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: orange,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-2, -2),
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          ),
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.10),
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'mooli',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
