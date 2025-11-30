import 'package:flutter/material.dart';

class FoodImage extends StatelessWidget {
  final String image;
  const FoodImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: image.isNotEmpty
          ? Image.asset(
              image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            )
          : Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[200],
              child: const Icon(Icons.fastfood, size: 80, color: Colors.grey),
            ),
    );
  }
}
