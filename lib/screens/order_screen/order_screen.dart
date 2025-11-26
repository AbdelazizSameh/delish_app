import 'package:flutter/material.dart';
import '../../widgets/order_screen_widgets/checkout_footer.dart';
import '../../widgets/order_screen_widgets/order_item_card.dart';
import '../../widgets/order_screen_widgets/recommendation_card.dart';
import '../../widgets/order_screen_widgets/total_row.dart';
import '../checkout_screen/checkout_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orderItems = [
    {
      'name': 'Carbonara pasta',
      'details': '+ Packaging fee \n + Parmesan cheese',
      'price': 12.50,
      'quantity': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=600',
    },
    {
      'name': 'Carbonara pasta',
      'details': '+ Packaging fee \n + Parmesan cheese',
      'price': 15.50,
      'quantity': 1,
      'imageUrl':
          'https://images.unsplash.com/photo-1600891964599-f61ba0e24092?w=600',
    },
  ];

  final List<Map<String, dynamic>> recommendations = [
    {
      'name': 'Tiramisu',
      'price': 6.80,
      'imageUrl':
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
    },
  ];

  void increase(int index) => setState(() => orderItems[index]['quantity']++);

  void decrease(int index) {
    if (orderItems[index]['quantity'] > 1) {
      setState(() => orderItems[index]['quantity']--);
    }
  }

  double get total => orderItems.fold(
    0.0,
    (sum, item) => sum + (item['price'] * item['quantity']),
  );

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFF5722);

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

            ...List.generate(
              orderItems.length,
              (i) => OrderItemCard(
                item: orderItems[i],
                onAdd: () => increase(i),
                onRemove: () => decrease(i),
              ),
            ),

            const SizedBox(height: 8),
            const Divider(),

            TotalRow(amount: total, color: primaryColor),

            const Divider(),
            const SizedBox(height: 12),

            const Text(
              'Recommendations',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recommendations.length,
                separatorBuilder: (_, __) => const SizedBox(width: 15),
                itemBuilder: (_, index) {
                  final r = recommendations[index];
                  return RecommendationCard(
                    name: r['name'],
                    price: r['price'],
                    imageUrl: r['imageUrl'],
                  );
                },
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),

      bottomNavigationBar: CheckoutFooter(
        total: total,
        onCheckout: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  CheckoutScreen(orderItems: orderItems, totalAmount: total),
            ),
          );
        },
      ),
    );
  }
}
