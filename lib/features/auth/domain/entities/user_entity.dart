import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String username;
  final String email;
  final String? password;
  const UserEntity(
      {this.id, required this.email, this.password, required this.username});
  @override
  List<Object?> get props => [username, email, password];
}
