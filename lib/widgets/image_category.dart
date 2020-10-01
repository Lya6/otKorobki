import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCategory extends StatelessWidget {
  String imageUrl;

  ImageCategory({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            //borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: imageProvider, scale: 3),
          ),
        );
      },
      placeholder: (context, url) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) => Image.asset("images/no_logo.png"),
    );
  }
}
