import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_cubit/search_cubit.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_result_bloc/search_result_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/search_results.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/auto_complete_search_item.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/chip_widget.dart';
import 'package:food_campanion/features/recipes/presentation/widgets/search_category_item.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchPageState>(builder: (context, state) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search Recipes..",
                      hintStyle: const TextStyle(fontFamily: 'mooli'),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search, color: Colors.orange),
                        onPressed: () {},
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 20),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          style: BorderStyle.solid,
                          color: orange,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.black.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(15))),
                  onChanged: (value) {
                    if (value.length > 3) {
                      BlocProvider.of<SearchCubit>(context).textChange(value);
                    }
                  },
                  onSubmitted: (v) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => sl<SearchResultBloc>(),
                          child: SearchResults(
                            id: v,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          body: SafeArea(
              child: (state.status == Status.success &&
                      state.searchList.isNotEmpty)
                  ? ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ...state.searchList.map((list) {
                          return SearchAutoCompleteTile(list: list);
                        }).toList()
                      ],
                    )
                  : state.status == Status.loading
                      ? const Center(child: LoadingWidget())
                      : ListView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 20),
                              child: Text(
                                "Most Recent Searches by People",
                                style: TextStyle(
                                  fontFamily: 'acme',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  ChipWidget("Baking"),
                                  ChipWidget("Vegetarian"),
                                  ChipWidget("Sauces"),
                                  ChipWidget("Meat"),
                                  ChipWidget("Turkey"),
                                  ChipWidget("Chicken"),
                                  ChipWidget("Sausages"),
                                  ChipWidget("Mince"),
                                  ChipWidget("Burgers"),
                                  ChipWidget("Pasta"),
                                  ChipWidget("Noodles"),
                                  ChipWidget("Pizza"),
                                  ChipWidget("Soups"),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25.0, vertical: 10),
                              child: Text(
                                "Recipes by categories",
                                style: TextStyle(
                                  fontFamily: 'acme',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            CategoryTile(
                                text: "main course",
                                image:
                                    "https://images.unsplash.com/photo-1559847844-5315695dadae?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=740&q=80"),
                            CategoryTile(
                                text: "side dish",
                                image:
                                    "https://images.unsplash.com/photo-1534938665420-4193effeacc4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80"),
                            CategoryTile(
                                text: "dessert",
                                image:
                                    "https://images.unsplash.com/photo-1587314168485-3236d6710814?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=670&q=80"),
                            CategoryTile(
                                text: "appetizer",
                                image:
                                    "https://images.unsplash.com/photo-1541529086526-db283c563270?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
                            CategoryTile(
                              text: "salad",
                              image:
                                  "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                            ),
                            CategoryTile(
                              text: "bread",
                              image:
                                  "https://images.unsplash.com/photo-1509440159596-0249088772ff?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=752&q=80",
                            ),
                            CategoryTile(
                              text: "breakfast",
                              image:
                                  "https://images.unsplash.com/photo-1525351484163-7529414344d8?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=80",
                            ),
                            CategoryTile(
                              text: "soup",
                              image:
                                  "https://images.unsplash.com/photo-1547592166-23ac45744acd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80",
                            ),
                            CategoryTile(
                              text: "beverage",
                              image:
                                  "https://images.unsplash.com/photo-1595981267035-7b04ca84a82d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            CategoryTile(
                              text: "sauce",
                              image:
                                  "https://images.unsplash.com/photo-1472476443507-c7a5948772fc?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            CategoryTile(
                              text: "marinade",
                              image:
                                  "https://images.unsplash.com/photo-1598511757337-fe2cafc31ba0?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            CategoryTile(
                              text: "fingerfood",
                              image:
                                  "https://images.unsplash.com/photo-1605333396915-47ed6b68a00e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            CategoryTile(
                              text: "snack",
                              image:
                                  "https://images.unsplash.com/photo-1599490659213-e2b9527bd087?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80",
                            ),
                            CategoryTile(
                              text: "drink",
                              image:
                                  "https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                            ),
                          ],
                        )),
        ),
      );
    });
  }
}
