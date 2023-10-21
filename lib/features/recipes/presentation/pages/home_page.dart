import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/widgets/custom_error_widget.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/home_widget.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeRecipeScreenState();
}

class _HomeRecipeScreenState extends State<HomePage> {
  late final HomeBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<HomeBloc>(context);
    bloc.add(LoadHomeEvent());

    super.initState();
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
            "                     FoodCampanion",
            style: TextStyle(
                color: Colors.orange,
                fontFamily: 'acme',
                fontSize: 30,
                fontWeight: FontWeight.w900),
          ),
        ),
        backgroundColor: Colors.white,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const Center(child: LoadingWidget());
            } else if (state is HomeSuccessState) {
              return RefreshIndicator(
                color: orange,
                onRefresh: () => refreshHome(context),
                child: HomeScreenWidget(
                    breakfast: state.breakfast,
                    vegan: state.vegan,
                    drinks: state.drinks,
                    burgers: state.burgers,
                    pizza: state.pizza,
                    cake: state.cake,
                    soup: state.soup,
                    salad: state.salad),
              );
            } else if (state is HomeErrorState) {
              return Center(child: customErrorWidget('Something went Wrong'));
            } else {
              return const Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }

  Future<void> refreshHome(BuildContext context) async {
    return BlocProvider.of<HomeBloc>(context).add(RefreshHomeEvent());
  }
}
