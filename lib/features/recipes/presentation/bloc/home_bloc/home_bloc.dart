import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/core/failures_exceptions/failures/failures.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_recipes_usecase.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetRecipesUsecase getRecipesUsecase;

  HomeBloc({required this.getRecipesUsecase}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is LoadHomeEvent || event is RefreshHomeEvent) {
        try {
          emit(HomeLoadingState());
          final data = await Future.wait([
            getRecipesUsecase.call('breakfast', 5),
            getRecipesUsecase.call('vegan', 3),
            getRecipesUsecase.call('drinks', 5),
            getRecipesUsecase.call('burger', 3),
            getRecipesUsecase.call('pizza', 5),
            getRecipesUsecase.call('cake', 3),
            getRecipesUsecase.call('soup', 3),
            getRecipesUsecase.call('salad', 3),
          ]);
          emit(HomeSuccessState(
              breakfast: data[0].fold((failure) => [], (food) => food.list),
              vegan: data[1].fold((failure) => [], (food) => food.list),
              drinks: data[2].fold((failure) => [], (food) => food.list),
              burgers: data[3].fold((failure) => [], (food) => food.list),
              pizza: data[4].fold((failure) => [], (food) => food.list),
              cake: data[5].fold((failure) => [], (food) => food.list),
              soup: data[6].fold((failure) => [], (food) => food.list),
              salad: data[7].fold((failure) => [], (food) => food.list)));
        } on Failure {
          emit(HomeErrorState());
        }
      }
    });
  }
}
