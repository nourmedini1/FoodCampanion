import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/presentation/widgets/modify_country_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/modify_email_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/modify_password_widget.dart';
import 'package:food_campanion/features/users/presentation/widgets/modify_username_widget.dart';

class UserDetailsPage extends StatefulWidget {
  final String toModify;
  const UserDetailsPage({super.key, required this.toModify});

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    switch (widget.toModify) {
      case 'email':
        return const ModifyEmailWidget();
      case 'password':
        return const ModifyPasswordWidget();
      case 'username':
        return const ModifyUsernameWidget();
      case 'country':
        return const ModifyCountryWidget();
      default:
        return const Placeholder();
    }
  }
}
