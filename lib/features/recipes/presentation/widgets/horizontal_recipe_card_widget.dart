import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipe_info_bloc/recipe_info_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/recipe_info_page.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class ListItem extends StatefulWidget {
  final FoodType meal;
  const ListItem({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  _Listmealtate createState() => _Listmealtate();
}

class _Listmealtate extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: const Duration(microseconds: 600),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => sl<RecipeInfoBloc>(),
                child: RecipeInfo(
                  id: widget.meal.id,
                ),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
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
              ],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 90,
                      width: 170,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        boxShadow: const [
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
                        ],
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(widget.meal.image),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.meal.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'mooli',
                              color: black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${widget.meal.readyInMinutes} min to prepare ',
                          style: TextStyle(
                              fontFamily: 'mooli',
                              color: orange,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
