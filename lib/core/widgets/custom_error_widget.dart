import 'package:flutter/material.dart';

Widget customErrorWidget(String errorMessage) {
  return Center(
      child: Container(
    height: 120,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.red, fontSize: 17),
        )
      ],
    ),
  ));
}
