import 'package:delish/models/OrderModel.dart';
import 'package:delish/screens/checkout_screen/checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Services/firebase/GetFunctions/getfunctions.dart';
import '../../widgets/order_screen_widgets/checkout_footer.dart';
import '../../widgets/order_screen_widgets/order_item_card.dart';
import '../../widgets/order_screen_widgets/total_row.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({required this.orderId, super.key});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    double? data;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: const Text(
          'Your order',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            const Text(
              "Order items",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            FutureBuilder(
              future: FirestoreGetters().getOrderDetails(
                FirebaseAuth.instance.currentUser!.uid,
                orderId,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(child: Text('No order found.'));
                }

                // snapshot.data = Map<String, dynamic>
                Order order = Order.fromMap(snapshot.data!);

                return Column(
                  children: [
                    OrderItemCard(order: order),
                    const SizedBox(height: 12),
                  ],
                );
              },
            ),

            const SizedBox(height: 8),
            const Divider(),

            StreamBuilder<double>(
              stream: FirestoreGetters().getTotalPriceOfOrder(
                FirebaseAuth.instance.currentUser!.uid,
                orderId,
              ),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (asyncSnapshot.hasError) {
                  return Center(child: Text('Error: ${asyncSnapshot.error}'));
                }

                final price = asyncSnapshot.data ?? 0.0;

                return TotalRow(price: price);
              },
            ),

            const Divider(),
            const SizedBox(height: 112),
          ],
        ),
      ),

      bottomNavigationBar: StreamBuilder(
        stream: FirestoreGetters().getTotalPriceOfOrder(
          FirebaseAuth.instance.currentUser!.uid,
          orderId,
        ),
        builder: (context, asyncSnapshot) {
          return CheckoutFooter(
            total: asyncSnapshot.data ?? 0,
            onCheckout: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(orderId: orderId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
