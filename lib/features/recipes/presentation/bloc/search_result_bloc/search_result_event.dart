part of 'search_result_bloc.dart';

sealed class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class LoadSearchResults extends SearchResultEvent {
  final String searchText;
  const LoadSearchResults({
    required this.searchText,
  });
  @override
  List<Object> get props => [searchText];
}
