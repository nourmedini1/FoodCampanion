import 'package:food_campanion/features/users/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.email,
      required super.username,
      required super.country,
      super.id,
      super.foodPreference,
      super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        username: json['username'],
        foodPreference: json['foodPreference'],
        country: json['country']);
  }

  factory UserModel.fromEntity(UserEntity userEntity) {
    return UserModel(
        email: userEntity.email,
        username: userEntity.username,
        foodPreference: userEntity.foodPreference,
        password: userEntity.password,
        id: userEntity.id,
        country: userEntity.country);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id ?? '',
      "email": email,
      "password": password ?? '',
      "username": username,
      'country': country,
      'foodPreference': foodPreference ?? [],
    };
  }
}
