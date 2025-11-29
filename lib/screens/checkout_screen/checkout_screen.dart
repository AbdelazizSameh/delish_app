import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/OrderModel.dart';
import '../../widgets/checkout_screen_widgets/order_summary_list.dart';
import '../../widgets/checkout_screen_widgets/payment_section.dart';
import '../../widgets/checkout_screen_widgets/shipping_section.dart';
import '../../widgets/checkout_screen_widgets/submit_button.dart';
import '../order_status/Order_status.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key, required this.orderItems});
  List<Order> orderItems;

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE65100);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 28, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ShippingSection(),

            const SizedBox(height: 10),
            const Divider(),
            const PaymentSection(),

            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),

            StreamBuilder(
              stream: FirestoreGetters().getUserOrders(
                FirebaseAuth.instance.currentUser!.uid,
              ),
              builder: (context, asyncSnapshot) {
                final data = asyncSnapshot.data;
                return OrderSummaryList(items: data!.map((e) => Order.fromMap(e)).toList());
              },
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),
      bottomNavigationBar: SubmitButton(
        label: 'SUBMIT ORDER',
        color: primaryColor,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OrderStatusScreen(),
            ),
          );
        },
      ),
    );
  }
}
