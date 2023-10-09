part of 'get_favorites_bloc.dart';

sealed class GetFavoritesEvent extends Equatable {
  const GetFavoritesEvent();

  @override
  List<Object> get props => [];
}

final class GetFavoritesRecipesEvent extends GetFavoritesEvent {
  final String userId;

  const GetFavoritesRecipesEvent({required this.userId});
  @override
  List<Object> get props => [userId];
}
