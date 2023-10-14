part of 'delete_from_favorites_bloc.dart';

sealed class DeleteFromFavoritesState extends Equatable {
  const DeleteFromFavoritesState();

  @override
  List<Object> get props => [];
}

final class DeleteFromFavoritesInitial extends DeleteFromFavoritesState {}

final class DeleteFromFavoritesLoading extends DeleteFromFavoritesState {}

final class DeleteFromFavoritesSuccess extends DeleteFromFavoritesState {}

final class DeleteFromFavoritesError extends DeleteFromFavoritesState {}
