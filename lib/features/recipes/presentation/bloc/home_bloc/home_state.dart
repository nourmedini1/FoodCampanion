part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<FoodType> breakfast;
  final List<FoodType> vegan;
  final List<FoodType> drinks;
  final List<FoodType> burgers;
  final List<FoodType> pizza;
  final List<FoodType> cake;
  final List<FoodType> soup;
  final List<FoodType> salad;
  const HomeSuccessState({
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
  List<Object> get props =>
      [breakfast, vegan, drinks, burgers, pizza, cake, soup, salad];
}

class HomeErrorState extends HomeState {}
