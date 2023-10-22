import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/data/models/food_type.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/get_favorites_bloc/get_favorites_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipe_info_bloc/recipe_info_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/recipe_info_page.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../bloc/delete_from_favorites_bloc/delete_from_favorites_bloc.dart';

class FavoriteItem extends StatefulWidget {
  final FoodType meal;
  final String userId;

  const FavoriteItem({
    Key? key,
    required this.meal,
    required this.userId,
  }) : super(key: key);

  @override
  _Listmealtate createState() => _Listmealtate();
}

class _Listmealtate extends State<FavoriteItem> {
  late BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DelayedDisplay(
      delay: const Duration(microseconds: 600),
      child: InkWell(
        onLongPress: () {
          print('pressed');
          AwesomeDialog(
                  title: 'Delete from favorites',
                  titleTextStyle: const TextStyle(
                      fontFamily: 'acme',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  desc: "delete ${widget.meal.name} from favorites",
                  descTextStyle: const TextStyle(
                      fontFamily: 'mooli',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  dialogType: DialogType.question,
                  animType: AnimType.topSlide,
                  showCloseIcon: true,
                  btnOk: BlocConsumer<DeleteFromFavoritesBloc,
                      DeleteFromFavoritesState>(
                    listener: (context, state) {
                      if (state is DeleteFromFavoritesError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            dismissDirection: DismissDirection.up,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                left: 10,
                                right: 10),
                            duration: const Duration(seconds: 3),
                            content: const Text(
                              'Failed to delete',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )));
                      } else if (state is DeleteFromFavoritesSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.lightGreen,
                            dismissDirection: DismissDirection.up,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).size.height - 100,
                                left: 10,
                                right: 10),
                            duration: const Duration(seconds: 1),
                            content: const Text(
                              'Deleted successfully!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            )));
                      }
                    },
                    builder: (context, state) {
                      if (state is DeleteFromFavoritesLoading) {
                        return const LoadingWidget();
                      } else if (state is DeleteFromFavoritesError) {
                        return deleteButton(
                            widget.userId, widget.meal, context);
                      } else if (state is DeleteFromFavoritesSuccess) {
                        BlocProvider.of<GetFavoritesBloc>(ctx).add(
                            GetFavoritesRecipesEvent(userId: widget.userId));
                        BlocProvider.of<DeleteFromFavoritesBloc>(ctx)
                            .add(DeleteFromFavoritesInitialize());

                        return const DeletedWidget(text: 'deleted');
                      }
                      return deleteButton(widget.userId, widget.meal, context);
                    },
                  ),
                  dialogBorderRadius: BorderRadius.circular(20),
                  context: context)
              .show();
        },
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

GestureDetector deleteButton(
    String? userId, FoodType favorite, BuildContext context) {
  return GestureDetector(
      onTap: () {
        BlocProvider.of<DeleteFromFavoritesBloc>(context).add(
            DeleteFromFavoriteRecipesEvent(recipe: favorite, userId: userId!));
      },
      child: const DeletedWidget(
        text: 'delete',
      ));
}

class DeletedWidget extends StatelessWidget {
  final String text;
  const DeletedWidget({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: orange,
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
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'mooli',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
