import 'package:floor/floor.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> saveUser(UserModel userModel);
  @delete
  Future<void> deleteUser(UserModel userModel);
  @Query('SELECT * FROM user')
  Future<List<UserModel>> getSavedUsers();
  @update
  Future<void> updateSavedUser(UserModel userModel);
}
