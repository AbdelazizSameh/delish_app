import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCachedImageNetwork extends StatelessWidget {
  const CustomCachedImageNetwork({
    super.key,
    required this.image,
    this.height = 170,
    this.fit = BoxFit.fill,
  });

  final String image;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: height,
      width: double.infinity,
      fit: fit,
      placeholder: (context, url) => Container(
        height: height,
        color: Colors.grey[200],
        child: const Center(child: CupertinoActivityIndicator()),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
  }
}
