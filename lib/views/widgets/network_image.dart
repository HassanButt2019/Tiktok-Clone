


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
   const CustomNetworkImage({Key? key,required this.imgUrl}) : super(key: key);

  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl:imgUrl,
      height: 100,
      width: 100,
      placeholder: (context, url) =>
      const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(
        Icons.error_outline,
        size: 10,
      ),
    );
  }
}
