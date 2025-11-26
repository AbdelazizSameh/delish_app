import 'package:flutter/material.dart';

class OrderItemRow extends StatelessWidget {
  final Map<String, dynamic> item;

  const OrderItemRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final total = item['price'] * item['quantity'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${item['quantity']}x ${item['name']}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            "€${total.toStringAsFixed(2).replaceAll('.', ',')}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
