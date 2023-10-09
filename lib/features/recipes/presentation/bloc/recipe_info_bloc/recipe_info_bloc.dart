import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/equipement.dart';
import 'package:food_campanion/features/recipes/data/models/nutrients.dart';
import 'package:food_campanion/features/recipes/data/models/recipe.dart';
import 'package:food_campanion/features/recipes/data/models/similar_list.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_recipe_info_usecase.dart';

part 'recipe_info_event.dart';
part 'recipe_info_state.dart';

class RecipeInfoBloc extends Bloc<RecipeInfoEvent, RecipeInfoState> {
  final GetRecipeInfoUsecase getRecipeInfoUsecase;
  RecipeInfoBloc({required this.getRecipeInfoUsecase})
      : super(RecipeInfoInitial()) {
    on<RecipeInfoEvent>((event, emit) async {
      if (event is LoadRecipeInfo) {
        final data = await getRecipeInfoUsecase.call(event.id);
        data.fold(
            (failure) => emit(RecipeInfoErrorState()),
            (recipeInfo) => emit(RecipeInfoSuccesState(
                recipe: recipeInfo[0],
                nutrient: recipeInfo[3],
                similar: recipeInfo[1].list,
                equipment: recipeInfo[2].items)));
      }
    });
  }
}
