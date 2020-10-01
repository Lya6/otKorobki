import 'package:template_application/constants_colors.dart';
import 'package:flutter/material.dart';

Stack backgroundImage() {
  return Stack(
    children: <Widget>[
      Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [kPrimaryColor, kWhiteColor],
          ),
        ),
      ),
      Positioned(
        right: 15,
        left: 15,
        bottom: 0,
        child: Container(
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/meridian.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    ],
  );
}
