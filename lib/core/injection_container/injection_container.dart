import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_campanion/core/network/internet_checker.dart';
import 'package:food_campanion/features/users/data/datasources/local/app_database.dart';
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

  //! Features

  // <<<<<<<<<< users feature >>>>>>>>>>>>>>>>>

  //---------------------------- data-------------------------------

  //local datasouces
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton<LocalDatasource>(
      () => LocalDataSourceImpl(appDatabase: sl()));

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
  sl.registerFactory(() => UsersBloc(
      deleteUserUsecase: sl(),
      getSavedUsersUsecase: sl(),
      loginLocalUsecase: sl(),
      loginRemoteUsecase: sl(),
      saveUserUsecase: sl(),
      signInUsecase: sl(),
      updateUserUsecase: sl()));
}
