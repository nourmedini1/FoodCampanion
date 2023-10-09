part of 'search_result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

final class SearchResultInitial extends SearchResultState {}

class SearchResultsLoading extends SearchResultState {}

class SearchResultsSuccess extends SearchResultState {
  final List<SearchResult> results;
  const SearchResultsSuccess({
    required this.results,
  });
  @override
  List<Object> get props => [results];
}

class SearchResultsError extends SearchResultState {}

class HomeFailureState extends SearchResultState {}
