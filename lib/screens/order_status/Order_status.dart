import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:delish/utils/general_functions.dart';
import 'package:delish/widgets/order_status_widgets/OrderSammaryInDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../widgets/order_status_widgets/order_card.dart';
import '../../widgets/order_status_widgets/summary_text.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    final estimatedReadyTime = DateTime.now().add(const Duration(hours: 3));

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
              children: [
                SummaryText("Restaurant: Delish", isMain: true),
                const SizedBox(height: 4),
                SummaryText("Order Time: 01:30 PM"),
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>?>(
              future: FirestoreGetters().getOrderDetails(
                FirebaseAuth.instance.currentUser!.uid,
                orderId,
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                } else if (!asyncSnapshot.hasData ||
                    asyncSnapshot.data == null) {
                  return const Center(child: Text('Order not found.'));
                }
                final currentUser = FirebaseAuth.instance.currentUser?.uid;

                final data = Order.fromMap(asyncSnapshot.data!,currentUser);
                return Ordersammaryindetails(orders: data);
              },
            ),
            const SizedBox(height: 16),
            OrderCard(
              title: "Status Tracker",
              children: [
                StreamBuilder<Map<String, dynamic>?>(
                  stream: FirestoreGetters().getOrderDetailsStream(
                    FirebaseAuth.instance.currentUser!.uid,
                    orderId,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError ||
                        !snapshot.hasData ||
                        snapshot.data == null) {
                      return const Center(
                        child: Text('Error fetching order status'),
                      );
                    }

                    final status = snapshot.data!['status'] ?? 'placed';
                    return StatusTracker(
                      status: status.toString(),
                      color: const Color(0xFFFF7043),
                    );
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Estimated Ready Time: ${formatDateTime(estimatedReadyTime)}',
                    style: const TextStyle(
                      color: Color(0xFFFF7043),
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

class StatusTracker extends StatelessWidget {
  final String status;
  final Color color;

  const StatusTracker({super.key, required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'label': 'Order Placed', 'icon': Icons.check, 'key': 'placed'},
      {'label': 'Preparing', 'icon': Icons.restaurant_menu, 'key': 'preparing'},
      {
        'label': 'Ready for Pickup',
        'icon': Icons.shopping_bag,
        'key': 'completed',
      },
    ];

    int currentIndex = steps.indexWhere((s) => s['key'] == status);
    if (currentIndex == -1) currentIndex = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: steps.map((step) {
        int index = steps.indexOf(step);
        bool done = index < currentIndex;
        bool active = index == currentIndex;

        return Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active
                    ? color
                    : done
                    ? Colors.white
                    : Colors.grey.shade200,
                border: Border.all(
                  color: done || active ? color : Colors.grey.shade400,
                  width: done || active ? 2 : 1,
                ),
              ),
              child: Center(
                child: Icon(
                  done ? Icons.check : step['icon'] as IconData,
                  size: 26,
                  color: active
                      ? Colors.white
                      : done
                      ? color
                      : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step['label'] as String,
              style: TextStyle(
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
                color: active ? color : Colors.black87,
                fontSize: 12,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
