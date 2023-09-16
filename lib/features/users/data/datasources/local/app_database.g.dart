// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` TEXT, `username` TEXT NOT NULL, `email` TEXT NOT NULL, `password` TEXT, `country` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'password': item.password,
                  'country': item.country
                }),
        _userModelUpdateAdapter = UpdateAdapter(
            database,
            'user',
            ['id'],
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'password': item.password,
                  'country': item.country
                }),
        _userModelDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['id'],
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'username': item.username,
                  'email': item.email,
                  'password': item.password,
                  'country': item.country
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final UpdateAdapter<UserModel> _userModelUpdateAdapter;

  final DeletionAdapter<UserModel> _userModelDeletionAdapter;

  @override
  Future<List<UserModel>> getSavedUsers() async {
    return _queryAdapter.queryList('SELECT * FROM user',
        mapper: (Map<String, Object?> row) => UserModel(
            email: row['email'] as String,
            username: row['username'] as String,
            country: row['country'] as String,
            id: row['id'] as String?,
            password: row['password'] as String?));
  }

  @override
  Future<void> saveUser(UserModel userModel) async {
    await _userModelInsertionAdapter.insert(
        userModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSavedUser(UserModel userModel) async {
    await _userModelUpdateAdapter.update(userModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteUser(UserModel userModel) async {
    await _userModelDeletionAdapter.delete(userModel);
  }
}
