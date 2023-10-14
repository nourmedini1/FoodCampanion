import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/search_result_bloc/search_result_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/search_results.dart';

class CategoryTile extends StatelessWidget {
  final String text;
  final String image;
  const CategoryTile({Key? key, required this.text, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              offset: Offset(-2, -2),
              blurRadius: 12,
              color: Color.fromRGBO(0, 0, 0, 0.05),
            ),
            BoxShadow(
              offset: Offset(2, 2),
              blurRadius: 5,
              color: Color.fromRGBO(0, 0, 0, 0.10),
            )
          ], borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: ListTile(
              leading: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(image),
                          fit: BoxFit.cover))),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => sl<SearchResultBloc>(),
                      child: SearchResults(
                        id: text,
                      ),
                    ),
                  ),
                );
              },
              title: Text(
                text,
                style: const TextStyle(
                    fontFamily: 'mooli', fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.arrow_right_alt)),
        ),
      ),
    );
  }
}

class SearchResultsBloc {}
