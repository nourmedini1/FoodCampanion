import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_campanion/core/network/internet_checker.dart';
import 'package:food_campanion/features/recipes/data/datasources/local/recipes_local_data_source.dart';
import 'package:food_campanion/features/recipes/data/datasources/remote/recipes_remote_datasource.dart';
import 'package:food_campanion/features/recipes/data/repository/recipes_repository_impl.dart';
import 'package:food_campanion/features/recipes/domain/repository/recipes_repository.dart';
import 'package:food_campanion/features/recipes/domain/usecases/add_to_favorites_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/breakfast_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/burger_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/cake_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/dessert_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/dinner_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/drinks_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/get_favorites_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/pizza_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/popular_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/protein_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/random_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/related_to_country_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/search_recipe_usecase.dart';
import 'package:food_campanion/features/recipes/domain/usecases/vegan_recipes_usecase.dart';
import 'package:food_campanion/features/recipes/presentation/bloc/recipes_bloc/recipes_bloc.dart';
import 'package:food_campanion/features/users/data/datasources/local/local_datasource.dart';
import 'package:food_campanion/features/users/data/datasources/remote/remote_datasource.dart';
import 'package:food_campanion/features/users/data/repository/users_repository_impl.dart';
import 'package:food_campanion/features/users/domain/repository/users_repository.dart';
import 'package:food_campanion/features/users/domain/usecases/delete_user_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/get_saved_users_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/login_local_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/login_remote_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/save_user_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/sign_in_usecase.dart';
import 'package:food_campanion/features/users/domain/usecases/update_user_usecase.dart';
import 'package:food_campanion/features/users/presentation/bloc/save_user_bloc/save_user_bloc.dart';
import 'package:food_campanion/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //! core
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<InternetChecker>(
      () => InternetCheckerImpl(internetConnectionChecker: sl()));
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  //! Features

  // <<<<<<<<<< users feature >>>>>>>>>>>>>>>>>

  //---------------------------- data-------------------------------

  //local datasouces

  sl.registerLazySingleton<LocalDatasource>(
      () => LocalDataSourceImpl(sharedPreferences: sl()));

  // remote datasources
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton<RemoteDatasource>(
      () => RemoteDataSourceImpl(database: sl()));

  //repository
  sl.registerLazySingleton<UsersRepository>(() => UsersRepositoryImpl(
      sharedPreferences: sl(),
      internetChecker: sl(),
      localDatasource: sl(),
      remoteDatasource: sl()));

  //----------------- domain -------------------------------------

  //usecases
  sl.registerLazySingleton(() => DeleteUserUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => GetSavedUsersUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => LoginLocalUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => LoginRemoteUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => SaveUserUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => SignInUsecase(usersRepository: sl()));
  sl.registerLazySingleton(() => UpdateUserUsecase(usersRepository: sl()));

  // ---------------- presentation ------------------------------
  //bloc
  sl.registerFactory(() => SaveUserBloc(saveUserUsecase: sl()));
  sl.registerFactory(() => UsersBloc(
      deleteUserUsecase: sl(),
      getSavedUsersUsecase: sl(),
      loginLocalUsecase: sl(),
      loginRemoteUsecase: sl(),
      signInUsecase: sl(),
      updateUserUsecase: sl()));

// <<<<<<<<<<<<< Recipes Feature >>>>>>>>>>>>>>>

// ------ data ---------

//datasources

//local
  sl.registerLazySingleton<RecipesLocalDatasource>(
      () => RecipesLocalDataSourceImpl(sharedPreferences: sl()));

//remote

  sl.registerLazySingleton<RecipesRemoteDataSource>(
      () => RecipesRemoteDatasourceImpl(client: sl()));

//repository
  sl.registerLazySingleton<RecipesRepository>(() => RecipesRepositoryImpl(
      recipesLocalDatasource: sl(),
      recipesRemoteDataSource: sl(),
      internetChecker: sl()));

//----------- domain ----------------

//usecases
  sl.registerLazySingleton(
      () => AddToFavoritesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => GetFavoritesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(
      () => BreakfastRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => DinnerRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => DrinksRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => BurgerRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => PizzaRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => CakeRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(
      () => DessertRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(
      () => PopularRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(
      () => ProteinRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => RandomRecipeUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(
      () => RelatedToCountryRecipesUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => SearchRecipeUsecase(recipesRepository: sl()));
  sl.registerLazySingleton(() => VeganRecipesUsecase(recipesRepository: sl()));

//------------- presentation ----------------
//bloc
  sl.registerFactory(() => RecipesBloc(
      addToFavoritesUsecase: sl(),
      cakeRecipesUsecase: sl(),
      breakfastRecipesUsecase: sl(),
      burgerRecipesUsecase: sl(),
      dessertRecipesUsecase: sl(),
      dinnerRecipesUsecase: sl(),
      drinksRecipesUsecase: sl(),
      getFavoritesUsecase: sl(),
      pizzaRecipesUsecase: sl(),
      popularRecipesUsecase: sl(),
      proteinRecipesUsecase: sl(),
      randomRecipeUsecase: sl(),
      relatedToCountryRecipesUsecase: sl(),
      searchRecipeUsecase: sl(),
      veganRecipesUsecase: sl()));
}
