import 'package:flutter/material.dart';

Widget logo(double h, double w) {
  return new Hero(
    tag: (h * w + h).toString(),
    child: Container(
      alignment: Alignment.center,
      width: w,
      height: h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/13.png"),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}