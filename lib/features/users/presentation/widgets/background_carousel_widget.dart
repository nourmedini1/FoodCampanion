import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget backgroundImages(BuildContext appContext) {
  const String asset = 'lib/core/assets/images/signup_images/photo';
  const List<String> assets = [
    "${asset}1.jpg",
    "${asset}2.jpg",
    "${asset}3.jpg",
    "${asset}4.jpg",
  ];
  return CarouselSlider.builder(
      itemCount: assets.length,
      itemBuilder: (context, index, realIndex) {
        return Image.asset(
          assets[index],
          fit: BoxFit.cover,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
        );
      },
      options: CarouselOptions(
          pageSnapping: false,
          viewportFraction: 1,
          height: MediaQuery.of(appContext).size.height,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 10),
          autoPlayAnimationDuration: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn));
}
