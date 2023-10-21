import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/animation/delayed_display.dart';
import 'package:food_campanion/core/widgets/loading_widget.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/add_favorite_bloc/add_favorite_bloc.dart';
import 'package:food_campanion/features/users/presentation/widgets/account_settings_widget.dart';
import 'package:food_campanion/features/users/presentation/bloc/logout_bloc/logout_bloc.dart';
import 'package:food_campanion/features/users/presentation/pages/login_page.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Center(
              child: Text(
            'FoodCampanion',
            style: TextStyle(
                color: Colors.orange,
                fontSize: 30,
                fontFamily: 'acme',
                fontWeight: FontWeight.w800),
          )),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(
              height: 30,
            ),
            header('       Account Settings'),
            const AccountSettingsWidget(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: BlocConsumer<LogoutBloc, LogoutState>(
                listener: (context, state) {
                  if (state is LogoutError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        dismissDirection: DismissDirection.up,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height - 150,
                            left: 10,
                            right: 10),
                        duration: const Duration(seconds: 3),
                        content: const Text(
                          'Failed to logout',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.white),
                        )));
                  } else if (state is LogoutSuccess) {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (_) => false);
                  }
                },
                builder: (context, state) {
                  if (state is LogoutLoading) {
                    return const LoadingWidget();
                  } else if (state is LogoutSuccess) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logout(context),
                      ],
                    );
                  } else if (state is AddFavoriteError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logout(context),
                      ],
                    );
                  } else {
                    return DelayedDisplay(
                      delay: const Duration(milliseconds: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          logout(context),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
            header('         About FoodCampanion '),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    'FoodCampanion',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'acme'),
                  ),
                  Text(
                    ' is an app made using Spoonacular API.',
                    style: TextStyle(
                      fontFamily: 'mooli',
                      fontSize: 13,
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                ' This app provides a multitude of recipes from all over the world.\n you can search for a particular recipe or for a certain category.',
                style: TextStyle(
                  fontFamily: 'mooli',
                  fontSize: 13,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  header(String name) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DelayedDisplay(
            delay: const Duration(microseconds: 600),
            child: Text(name,
                style: const TextStyle(
                  fontFamily: 'acme',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
          ),
        ],
      ),
    );
  }
}

GestureDetector logout(BuildContext context) {
  return GestureDetector(
    onTap: () {
      BlocProvider.of<LogoutBloc>(context).add(LogoutUserEvent());
    },
    child: Container(
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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        child: Center(
          child: Text(
            'Logout',
            style: TextStyle(
              fontFamily: 'mooli',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    ),
  );
}
