import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/core/widgets/custom_error_widget.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/get_favorites_bloc/get_favorites_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/favorites_widget.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';
import 'package:food_campanion/features/users/utils/colors.dart';
import 'package:food_campanion/features/users/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late final GetFavoritesBloc getFavoritesBloc;
  late final String? userId;
  @override
  void initState() {
    super.initState();
    userId = UserModel.fromJson(
            json.decode(sl<SharedPreferences>().getString(CURRENT_USER)!))
        .id;

    getFavoritesBloc = BlocProvider.of<GetFavoritesBloc>(context);
    getFavoritesBloc.add(GetFavoritesRecipesEvent(userId: userId!));
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              '                   FoodCampanion',
              style: TextStyle(
                  fontFamily: 'acme',
                  color: Colors.orange,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),
          body: BlocBuilder<GetFavoritesBloc, GetFavoritesState>(
            builder: (context, state) {
              if (state is GetFavoritesLoading) {
                return const Center(
                  child: LoadingWidget(),
                );
              } else if (state is GetFavoritesSuccess) {
                return RefreshIndicator(
                    color: orange,
                    onRefresh: (() => refreshFavorites(context, userId)),
                    child: Center(
                        child: FavoritesWidget(favorites: state.favorites)));
              } else if (state is GetFavoritesError) {
                return Center(
                    child:
                        customErrorWidget('There are no favorite recipes yet'));
              }
              return const LoadingWidget();
            },
          ),
        ));
  }
}

Future<void> refreshFavorites(BuildContext context, String? userId) async {
  return BlocProvider.of<GetFavoritesBloc>(context)
      .add(GetFavoritesRecipesEvent(userId: userId!));
}
