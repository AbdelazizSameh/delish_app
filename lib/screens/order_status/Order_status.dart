import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:delish/widgets/order_status_widgets/OrderSammaryInDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/OrderModel.dart';
import '../../widgets/order_status_widgets/order_card.dart';
import '../../widgets/order_status_widgets/status_tracker.dart';
import '../../widgets/order_status_widgets/summary_text.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                SizedBox(height: 4),
                SummaryText("Order Time: 01:30 PM"),
              ],
            ),

            const SizedBox(height: 16),

            StreamBuilder(
              stream: FirestoreGetters().getUserOrders(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, asyncSnapshot) {
                final data = asyncSnapshot.data;
                final order = data?.map((e) => Order.fromMap(e)).toList() ?? [];
                return Ordersammaryindetails(orders: order);
              },
            ),
            const SizedBox(height: 16),
            OrderCard(
              title: "Status Tracker",
              children: [
                // FutureBuilder(
                //   future: FirestoreGetters().getOrderDetails(
                //     FirebaseAuth.instance.currentUser!.uid,
                //     "mmm"
                    
                //   ),
                //   builder: (context, asyncSnapshot) {
                //     return StatusTracker(color: Color(0xFFFF7043),status: 
                    
                //     );
                //   }
                // ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'Estimated Ready Time: 02:00 PM',
                    style: TextStyle(
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
