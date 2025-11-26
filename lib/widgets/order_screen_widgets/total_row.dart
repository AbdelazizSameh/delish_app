import 'package:flutter/material.dart';

class TotalRow extends StatelessWidget {
  final double amount;
  final Color color;

  const TotalRow({super.key, required this.amount, required this.color});

  @override
  Widget build(BuildContext context) {
    final String total = '€${amount.toStringAsFixed(2).replaceAll('.', ',')}';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            total,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
