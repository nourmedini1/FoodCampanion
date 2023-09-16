import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_campanion/core/failures_exceptions/exceptions.dart';
import 'package:food_campanion/features/users/data/models/user_model.dart';

abstract class RemoteDatasource {
  Future<UserModel> signIn(UserModel userModel);
  Future<UserModel> loginRemote(String email, String password);
  Future<UserModel> updateRemote(UserModel userModel);
}

class RemoteDataSourceImpl extends RemoteDatasource {
  FirebaseFirestore database;

  RemoteDataSourceImpl({required this.database});
  @override
  Future<UserModel> loginRemote(String email, String password) async {
    final users = database.collection('users');

    QuerySnapshot<Map<String, dynamic>> user = await users
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get();
    if (user.size > 0) {
      final currentUser = user.docs.first;
      final usermodel = UserModel.fromJson(currentUser.data());
      return Future.value(usermodel);
    } else {
      throw RemoteLoginException();
    }
  }

  @override
  Future<UserModel> signIn(UserModel userModel) async {
    final body = userModel.toJson();
    final users = database.collection('users');
    bool test = false;
    await users.doc().set(body).whenComplete(() => test = true);
    if (test == true) {
      return Future.value(userModel);
    } else {
      throw SigninException();
    }
  }

  @override
  Future<UserModel> updateRemote(UserModel userModel) async {
    final body = userModel.toJson();
    final users = database.collection('users');
    bool test = false;
    await users.doc(userModel.id).update(body).whenComplete(() => test = true);
    if (test == true) {
      return Future.value(userModel);
    } else {
      throw RemoteUpdateException();
    }
  }
}
