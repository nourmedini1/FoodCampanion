import 'package:flutter/material.dart';
import 'package:food_campanion/features/users/utils/colors.dart';

Container shadow(double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        gradient: LinearGradient(
      colors: [transparent, black.withOpacity(0.99)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    )),
  );
}
