

import 'package:flutter/material.dart';

class Prices extends StatelessWidget {
  final double price;
  const Prices({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '\$${price.toStringAsFixed(2)}',
          style: const TextStyle(
            color: Color(0xFFFF4400),
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '\$${(price * 1.15).toStringAsFixed(2)}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            decoration: TextDecoration.lineThrough,
          ),
        ),
      ],
    );
  }
}
