import 'package:flutter/material.dart';

Widget button(String label, Color color1, Color color2, Function() onPressed) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      alignment: Alignment.center,
      height: 50,
      width: 200,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: const Color(0xff1D1617).withOpacity(0.07),
                offset: const Offset(0, 10),
                blurRadius: 4,
                spreadRadius: 0)
          ],
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(colors: [color1, color2])),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'mooli',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
