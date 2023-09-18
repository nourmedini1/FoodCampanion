import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

Widget appMotto(String motto) {
  return Container(
    padding: const EdgeInsets.all(20),
    child: Text(
      motto,
      style: TextStyle(
          color: whiteCards,
          fontFamily: 'acme',
          fontSize: 30,
          fontWeight: FontWeight.w800),
    ),
  );
}
