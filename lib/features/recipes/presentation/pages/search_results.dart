import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_result_bloc/search_result_bloc.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

import '../widgets/search_result_widget.dart';

class SearchResults extends StatefulWidget {
  final String id;
  const SearchResults({Key? key, required this.id}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late final SearchResultBloc bloc;
  @override
  void initState() {
    bloc = BlocProvider.of<SearchResultBloc>(context);
    bloc.add(LoadSearchResults(searchText: widget.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("FoodCampanion",
              style: TextStyle(
                  color: orange,
                  fontFamily: 'acme',
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
        ),
        body: BlocBuilder<SearchResultBloc, SearchResultState>(
          builder: (context, state) {
            if (state is SearchResultsLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is SearchResultsSuccess) {
              return Container(
                  child: SafeArea(
                      child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 13 / 16,
                  ),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ...state.results.map((result) {
                      return SearchResultItem(
                        result: result,
                      );
                    }).toList()
                  ],
                ),
              )));
            } else if (state is SearchResultsError) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(child: LoadingWidget());
            }
          },
        ),
      ),
    );
  }
}
