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
