import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipes_bloc/recipes_bloc.dart';
import 'package:food_campanion/features/users/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    String country = 'england';
    SharedPreferences sharedPreferences = sl<SharedPreferences>();
    Map<String, dynamic>? user =
        json.decode(sharedPreferences.getString('CURRENT_USER')!);
    if (user != null) {
      country = user['country'];
    }

    RecipesBloc bloc = BlocProvider.of<RecipesBloc>(context);

    bloc.add(RecipesRelatedToCountryEvent(country: country, options: null));
    Future.delayed(const Duration(milliseconds: 200)).then((_) => bloc
        .add(const RecipesBreakfastEvent(query: 'breakfast', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesDinnerEvent(query: 'dinner', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesBurgerEvent(query: 'burger', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then(
        (_) => bloc.add(const RecipesCakeEvent(query: 'cake', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesDessertEvent(query: 'dessert', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesDrinksEvent(query: 'drinks', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesPizzaEvent(query: 'pizza', options: null)));
    Future.delayed(const Duration(milliseconds: 200)).then((_) =>
        bloc.add(const RecipesVeganEvent(query: 'vegan', options: null)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          'FoodCampanion',
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
