import 'package:delish/models/OrderModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Services/firebase/GetFunctions/getfunctions.dart';
import '../../widgets/order_screen_widgets/checkout_footer.dart';
import '../../widgets/order_screen_widgets/order_item_card.dart';
import '../../widgets/order_screen_widgets/total_row.dart';
import '../checkout_screen/checkout_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            StreamBuilder(
              stream: FirestoreGetters().getUserOrders(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                } else {
                  List<Order> orders = snapshot.data!
                      .map((order) => Order.fromMap(order))
                      .toList();
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            return OrderItemCard(order: orders[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 8),
            const Divider(),
            StreamBuilder(
              stream: FirestoreGetters().getTotalPricesofOrders(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, asyncSnapshot) {
                return TotalRow(price: asyncSnapshot.data ?? 0);
              },
            ),

            const Divider(),
            const SizedBox(height: 112),
          ],
        ),
      ),
      bottomNavigationBar: StreamBuilder(
        stream: FirestoreGetters().getTotalPricesofOrders(
          FirebaseAuth.instance.currentUser!.uid,
        ),
        builder: (context, asyncSnapshot) {
          return CheckoutFooter(
            total: asyncSnapshot.data ?? 0,
            onCheckout: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (_) => 
              //     StreamBuilder(
              //       stream: FirestoreGetters()(
              //         FirebaseAuth.instance.currentUser!.uid,

              //       ),
              //       builder: (context, asyncSnapshot) {
              //         return CheckoutScreen(
              //           orderItems: asyncSnapshot.data!.map((e) => Order.fromMap(e)).toList(),
              //         );
              //       },
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
    );
  }
}
