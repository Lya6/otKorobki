import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:template_application/constants.dart';

class ImageSliderCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Carousel(
        boxFit: BoxFit.fitWidth,
        images: [
          Constants.image,
        ],
        indicatorBgPadding: 0.1,
        dotColor: Colors.black,
      ),
    );
  }
}
