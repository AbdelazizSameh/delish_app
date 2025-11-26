import 'package:flutter/material.dart';

import 'summury_row.dart';

class OrderSummaryList extends StatelessWidget {
  final List<Map<String, dynamic>> items;
  final double totalAmount;

  const OrderSummaryList({
    super.key,
    required this.items,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Order Summary',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 15),

        ...items.map((item) {
          double total = item['price'] * item['quantity'];
          return SummaryRow(
            title: '${item['quantity']}x ${item['name']}',
            value: '€${total.toStringAsFixed(2).replaceAll('.', ',')}',
          );
        }),

        const SizedBox(height: 12),

        SummaryRow(
          title: 'Total',
          value: '€${totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
          bold: true,
        ),
      ],
    );
  }
}
