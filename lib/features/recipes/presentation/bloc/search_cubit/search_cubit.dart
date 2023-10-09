import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_campanion/features/recipes/data/models/auto_complete.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_auto_complete_list_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchPageState> {
  final GetAutoCompleteListUsecase getAutoCompleteListUsecase;
  SearchCubit({required this.getAutoCompleteListUsecase})
      : super(SearchPageState.initial());

  void textChange(String text) async {
    emit(state.copyWith(status: Status.loading, searchText: text));
    final list = await getAutoCompleteListUsecase.call(text);
    list.fold(
        (l) => null,
        (searchlist) => emit(state.copyWith(
            status: Status.success, searchList: searchlist.list)));
  }
}
