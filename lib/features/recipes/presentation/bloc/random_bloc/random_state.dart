part of 'random_bloc.dart';

sealed class RandomState extends Equatable {
  const RandomState();

  @override
  List<Object> get props => [];
}

final class RandomInitial extends RandomState {}

class RandomLoadState extends RandomState {}

class RandomSuccesState extends RandomState {
  final Recipe recipe;
  final List<Similar> similar;
  final List<Equipment> equipment;
  final Nutrient nutrient;

  const RandomSuccesState({
    required this.recipe,
    required this.nutrient,
    required this.similar,
    required this.equipment,
  });
}

class RandomRecipeErrorState extends RandomState {}
