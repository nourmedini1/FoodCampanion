import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:food_campanion/features/users/data/datasources/local/DAO/user_dao.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [UserModel])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
}
