import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipes_bloc/recipes_bloc.dart';
import 'package:food_campanion/features/users/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChipWidget extends StatelessWidget {
  final String text;
  const ChipWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    var sharedPreferences = sl<SharedPreferences>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DelayedDisplay(
        delay: const Duration(microseconds: 600),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => sl<RecipesBloc>(),
                  child: SearchResults(
                    id: text,
                  ),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: sharedPreferences.getBool('dark') == null ||
                      sharedPreferences.getBool('dark') == true
                  ? const Color.fromARGB(255, 92, 92, 92)
                  : whiteCards,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-2, -2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.10),
                )
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: 'mooli',
                  fontWeight: FontWeight.bold,
                  color: orange,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
