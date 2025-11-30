import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../widgets/checkout_screen_widgets/order_summary_list.dart';
import '../../widgets/checkout_screen_widgets/payment_section.dart';
import '../../widgets/checkout_screen_widgets/shipping_section.dart';
import '../../widgets/checkout_screen_widgets/submit_button.dart';
import '../order_status/Order_status.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key, required this.orderId});
  final String orderId;
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

                final data = Order.fromMap(asyncSnapshot.data!);
                return OrderSummaryList(order: data, orderId: orderId);
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
              builder: (_) => OrderStatusScreen(orderId: orderId),
            ),
          );
        },
      ),
    );
  }
}
