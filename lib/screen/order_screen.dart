import 'package:delish_app/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'checkout_screen.dart';

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
    {
      'name': 'Tiramisu',
      'price': 6.80,
      'imageUrl':
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
    },
    {
      'name': 'Tiramisu',
      'price': 6.80,
      'imageUrl':
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
    },
    {
      'name': 'Tiramisu',
      'price': 6.80,
      'imageUrl':
          'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600',
    },
  ];

  void _incrementQuantity(int index) {
    setState(() {
      orderItems[index]['quantity']++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (orderItems[index]['quantity'] > 1) {
        orderItems[index]['quantity']--;
      }
    });
  }

  double _calculateTotal() {
    return orderItems.fold(
      0.0,
      (sum, item) => sum + (item['price'] * item['quantity']),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFFF5722);
    const Color secondaryTextColor = Colors.grey;

    final double totalAmount = _calculateTotal();
    final String formattedTotal =
        '€${totalAmount.toStringAsFixed(2).replaceAll('.', ',')}';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text(
          'Your order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Order items',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...List.generate(orderItems.length, (index) {
              return _buildOrderItemCard(
                item: orderItems[index],
                index: index,
                primaryColor: primaryColor,
                secondaryTextColor: secondaryTextColor,
              );
            }),
            const SizedBox(height: 8),
            const Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formattedTotal,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 7),
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
                separatorBuilder: (context, index) => const SizedBox(width: 15),
                itemBuilder: (context, index) {
                  final rec = recommendations[index];
                  return RecommendationCard(
                    name: rec['name'],
                    price: rec['price'],
                    imageUrl: rec['imageUrl'],
                  );
                },
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 20,
          left: 20,
          right: 20,
          top: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  orderItems: orderItems,
                  totalAmount: totalAmount,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            minimumSize: const Size(double.infinity, 55),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Text(
                  'Go to checkout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  formattedTotal,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItemCard({
    required Map<String, dynamic> item,
    required int index,
    required Color primaryColor,
    required Color secondaryTextColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.70),
            spreadRadius: 0.5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 15.0),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item['imageUrl'],
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item['details'],
                  style: TextStyle(fontSize: 14, color: secondaryTextColor),
                ),
                const SizedBox(height: 5),
                Text(
                  '€${item['price'].toStringAsFixed(2).replaceAll('.', ',')}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => _decrementQuantity(index),
                child: _circleButton(Icons.remove, primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item['quantity'].toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _incrementQuantity(index),
                child: _circleButton(Icons.add, primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, Color color) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}
