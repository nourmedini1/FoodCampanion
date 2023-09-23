import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/utils/strings.dart';

Widget customErrorWidget(String errorMessage) {
  return Center(
      child: Container(
    height: 120,
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          EMPTY_LOCAL_DATABASE_ERROR_MESSAGE,
          style: TextStyle(color: Colors.red, fontSize: 17),
        )
      ],
    ),
  ));
}
