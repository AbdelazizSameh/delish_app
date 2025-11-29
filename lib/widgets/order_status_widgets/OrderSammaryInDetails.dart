import 'package:delish/models/OrderModel.dart';
import 'package:flutter/material.dart';

class Ordersammaryindetails extends StatelessWidget {
  const Ordersammaryindetails({super.key, required this.orders});
  final Order orders;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFFF1E7),
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Oders  Itmes",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${orders.quantity}x ${orders.name}"),
                Text(" \$${orders.totalPrice}"),
              ],
            ),
            const Divider(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price: "),
                Text(" \$${orders.totalPrice}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
