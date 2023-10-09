part of 'add_favorite_bloc.dart';

sealed class AddFavoriteState extends Equatable {
  const AddFavoriteState();

  @override
  List<Object> get props => [];
}

final class AddFavoriteInitial extends AddFavoriteState {}

final class AddFavoriteLoading extends AddFavoriteState {}

final class AddFavoriteSuccess extends AddFavoriteState {}

final class AddFavoriteError extends AddFavoriteState {}
