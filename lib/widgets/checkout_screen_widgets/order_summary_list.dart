import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:delish/models/OrderModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'summury_row.dart';

class OrderSummaryList extends StatelessWidget {
  final List<Order> items;

  const OrderSummaryList({super.key, required this.items});

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

        ListView.builder(itemBuilder: (context, index) {
          final item = items[index];
          double total = item.totalPrice.toDouble() * item.quantity;
          return SummaryRow(
            title: '${item.quantity}x ${item.name}',
            value: '€${total.toStringAsFixed(2).replaceAll('.', ',')}',
          );
        }),

        const SizedBox(height: 12),

        StreamBuilder(
          stream: FirestoreGetters().getTotalPricesofOrders(
            FirebaseAuth.instance.currentUser!.uid,
          ),
          builder: (context, asyncSnapshot) {
            return SummaryRow(
              title: 'Total',
              value: '€${asyncSnapshot.data}',
              bold: true,
            );
          }
        ),
      ],
    );
  }
}
