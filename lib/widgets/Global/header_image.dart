import 'package:cached_network_image/cached_network_image.dart';
import 'package:delish/widgets/Global/custom_cached_image_network.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return CustomCachedImageNetwork(
      image: image,
      height: 280,
      fit: BoxFit.contain,
    );
  }
}
