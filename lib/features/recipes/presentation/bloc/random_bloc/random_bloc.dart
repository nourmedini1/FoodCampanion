import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/equipement.dart';
import 'package:food_campanion/features/recipes/data/models/nutrients.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/similar_list.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_random_recipe_usecase.dart';

part 'random_event.dart';
part 'random_state.dart';

class RandomBloc extends Bloc<RandomEvent, RandomState> {
  final GetRandomRecipeUsecase getRandomRecipeUsecase;
  RandomBloc({required this.getRandomRecipeUsecase}) : super(RandomInitial()) {
    on<RandomEvent>((event, emit) async {
      if (event is LoadRandomEvent) {
        emit(RandomLoadState());
        final data = await getRandomRecipeUsecase.call();
        data.fold(
            (failure) => emit(RandomRecipeErrorState()),
            (recipe) => emit(RandomSuccesState(
                recipe: recipe[0],
                nutrient: recipe[3],
                similar: recipe[1].list,
                equipment: recipe[2].items)));
      }
    });
  }
}
