import 'package:delish/models/OrderModel.dart';
import 'package:flutter/material.dart';

class Ordersammaryindetails extends StatelessWidget {
  const Ordersammaryindetails({super.key, required this.orders});
  final List<Order> orders;
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
              "OdersItmes",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ListView.builder(
              itemBuilder: (context, index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${orders[index].quantity}x ${orders[index].name}"),
                    Text(" \$${orders[index].totalPrice}"),
                  ],
                );
              },
            ),
            const Divider(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Price: "),
                Text(
                  "\$${orders.fold(0.0, (previous, element) => previous + element.totalPrice)}",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
