part of 'recipe_info_bloc.dart';

sealed class RecipeInfoState extends Equatable {
  const RecipeInfoState();

  @override
  List<Object> get props => [];
}

final class RecipeInfoInitial extends RecipeInfoState {}

class RecipeInfoLoadState extends RecipeInfoState {}

class RecipeInfoSuccesState extends RecipeInfoState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipment> equipment;
  final Nutrient nutrient;

  const RecipeInfoSuccesState({
    required this.recipe,
    required this.nutrient,
    required this.similar,
    required this.equipment,
  });
  @override
  List<Object> get props => [recipe, nutrient, similar, equipment];
}

class RecipeInfoErrorState extends RecipeInfoState {}
