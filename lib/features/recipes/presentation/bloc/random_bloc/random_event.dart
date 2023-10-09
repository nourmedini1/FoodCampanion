part of 'random_bloc.dart';

sealed class RandomEvent extends Equatable {
  const RandomEvent();

  @override
  List<Object> get props => [];
}

class LoadRandomEvent extends RandomEvent {}
