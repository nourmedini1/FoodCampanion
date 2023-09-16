import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String username;
  final String email;
  final String? password;
  final String country;
  final List<String>? foodPreference;
  const UserEntity(
      {this.id,
      required this.email,
      this.password,
      required this.username,
      required this.country,
      this.foodPreference});
  @override
  List<Object?> get props =>
      [id, username, email, password, country, foodPreference];
}
