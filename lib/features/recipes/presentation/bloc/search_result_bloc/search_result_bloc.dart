import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/search_results.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_search_results_usecase.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final GetSearchResultsUsecase getSearchResultsUsecase;
  SearchResultBloc({required this.getSearchResultsUsecase})
      : super(SearchResultInitial()) {
    on<SearchResultEvent>((event, emit) async {
      if (event is LoadSearchResults) {
        emit(SearchResultsLoading());
        final results =
            await getSearchResultsUsecase.call(event.searchText, 50);
        results.fold((failure) => emit(SearchResultsError()),
            (results) => emit(SearchResultsSuccess(results: results.list)));
      }
    });
  }
}
