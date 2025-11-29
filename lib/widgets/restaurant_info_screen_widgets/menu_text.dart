import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/items_model.dart';

class MenuText extends StatelessWidget {
  final int index;
  final ItemModel item;

  const MenuText({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    final Random rand = Random();
    final List<String> foodDescriptions = [
      "A delicious and freshly prepared dish with rich flavors.",
      "Made with high-quality ingredients for a satisfying taste.",
      "A perfect blend of spices and textures for food lovers.",
      "Fresh and healthy, packed with nutrients and flavor.",
      "A sweet and indulgent treat for dessert lovers.",
      "Light, tasty, and perfect for any time of the day.",
      "A hearty meal that warms your soul and delights your taste buds.",
      "Crispy on the outside, soft and flavorful inside.",
      "A classic favorite made with love and care.",
      "Rich in flavor, perfectly seasoned, and utterly delicious.",
      "A savory delight that satisfies every craving.",
      "Perfectly cooked and bursting with authentic flavors.",
      "A colorful dish that looks as good as it tastes.",
      "Comfort food that brings happiness in every bite.",
      "An exquisite combination of textures and tastes.",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$index. ${item.name}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          item.description,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              item.price.toString(),
              style: const TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              (item.price - item.price * 2.2).toStringAsFixed(2),
              style: TextStyle(
                color: Colors.grey.shade500,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
