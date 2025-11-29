import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      height: 280,
      width: double.infinity,
      fit: BoxFit.contain,
      placeholder: (context, url) => Container(
        height: 280,
        color: Colors.grey[200],
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      ),
      errorWidget: (context, url, error) => Container(
        height: 280,
        color: Colors.grey[200],
        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
      ),
    );
  }
}
