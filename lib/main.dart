import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_campanion/core/injection_container/injection_container.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipes_bloc/recipes_bloc.dart';
import 'package:food_campanion/features/recipes/presentation/pages/bottom_navigation_page.dart';
import 'package:food_campanion/features/users/presentation/bloc/save_user_bloc/save_user_bloc.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:food_campanion/features/users/presentation/pages/login_page.dart';
import 'package:food_campanion/features/users/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var logStatus = sl<SharedPreferences>().getBool(LOGGED_IN);
    bool check = logStatus != null && logStatus;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ((context) => sl<UsersBloc>())),
        BlocProvider(create: ((context) => sl<SaveUserBloc>())),
        BlocProvider(
          create: (context) => sl<RecipesBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: check ? const BottomNavView() : const LoginPage(),
      ),
    );
  }
}
