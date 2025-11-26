import 'package:flutter/material.dart';

import '../../widgets/checkout_screen_widgets/summury_row.dart';
import '../../widgets/order_status_widgets/order_card.dart';
import '../../widgets/order_status_widgets/order_item_row.dart';
import '../../widgets/order_status_widgets/status_tracker.dart';
import '../../widgets/order_status_widgets/summary_text.dart';

class OrderStatusScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems;

  const OrderStatusScreen({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE65100);
    const Color highlightColor = Color(0xFFFF7043);

    final double total = orderItems.fold(
      0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            OrderCard(
              title: "Order Summary",
              children: const [
                SummaryText("Restaurant: Delish", isMain: true),
                SizedBox(height: 4),
                SummaryText("Order Time: 01:30 PM"),
              ],
            ),

            const SizedBox(height: 16),

            OrderCard(
              title: "Order Items",
              children: [
                ...orderItems.map((item) => OrderItemRow(item: item)).toList(),
                const Divider(height: 24, thickness: 1),
                SummaryRow(
                  title: "Total:",
                  value: "€${total.toStringAsFixed(2).replaceAll('.', ',')}",
                ),
              ],
            ),

            const SizedBox(height: 16),

            OrderCard(
              title: "Status Tracker",
              children: [
                StatusTracker(color: highlightColor),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Estimated Ready Time: 02:00 PM',
                    style: TextStyle(
                      color: highlightColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
