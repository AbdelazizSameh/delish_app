import 'package:flutter/material.dart';

import '../../models/order.dart';
import 'summury_row.dart';

class OrderSummaryList extends StatelessWidget {
  final String orderId;
  final Order order;

  const OrderSummaryList({
    super.key,
    required this.orderId,
    required this.order,
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
        Text("${order.quantity}x ${order.name}"),

        const SizedBox(height: 12),
        SummaryRow(title: 'Total', value: '€${order.totalPrice}', bold: true),
      ],
    );
  }
}
