part of 'get_favorites_bloc.dart';

sealed class GetFavoritesState extends Equatable {
  const GetFavoritesState();

  @override
  List<Object> get props => [];
}

final class GetFavoritesInitial extends GetFavoritesState {}

final class GetFavoritesLoading extends GetFavoritesState {}

final class GetFavoritesSuccess extends GetFavoritesState {
  final List<FoodType> favorites;

  const GetFavoritesSuccess({required this.favorites});
  @override
  List<Object> get props => [favorites];
}

final class GetFavoritesError extends GetFavoritesState {}
