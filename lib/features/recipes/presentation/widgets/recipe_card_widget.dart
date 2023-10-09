import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipe_info_bloc/recipe_info_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/recipe_info_page.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class RecipeCardWidget extends StatefulWidget {
  const RecipeCardWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  final dynamic items;

  @override
  _RecipeCardWidgetState createState() => _RecipeCardWidgetState();
}

class _RecipeCardWidgetState extends State<RecipeCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => sl<RecipeInfoBloc>(),
                  child: RecipeInfo(
                    id: widget.items.id,
                  ),
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
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
              margin: const EdgeInsets.all(8),
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Container(
                      width: 200,
                      foregroundDecoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                      ),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          color: Colors.grey,
                        ),
                        imageUrl: widget.items.image,
                        fit: BoxFit.cover,
                        height: 150,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.all(9),
                    child: Text(
                      widget.items.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'mooli', fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Text(
                        "${widget.items.readyInMinutes} min to prepare",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'mooli',
                          color: orange,
                        ),
                      )),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Text(
                        '${widget.items.servings} servings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'mooli',
                          color: orange,
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
