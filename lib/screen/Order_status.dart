import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems;

  const OrderDetailsScreen({super.key, required this.orderItems});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE65100);
    const Color highlightColor = Color(0xFFFF7043);

    double total = orderItems.fold(
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
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildOrderCard(
              title: 'Order Summary',
              children: [
                _buildSummaryText('Restaurant: Delish', isMain: true),
                const SizedBox(height: 4),
                _buildSummaryText('Order Time: 01:30 PM'),
              ],
            ),
            const SizedBox(height: 16),

            _buildOrderCard(
              title: 'Order Items',
              children: [
                ...orderItems.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item['quantity']}x ${item['name']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '€${(item['price'] * item['quantity']).toStringAsFixed(2).replaceAll('.', ',')}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                const Divider(height: 24, thickness: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    _buildSummaryText(
                      '€${total.toStringAsFixed(2).replaceAll('.', ',')}',
                      isMain: true,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),

            _buildOrderCard(
              title: 'Status Tracker',
              children: [
                _buildStatusTracker(highlightColor),
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

  Widget _buildOrderCard({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Divider(height: 20, thickness: 0),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryText(String text, {bool isMain = false}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isMain ? 18 : 16,
        color: isMain ? Colors.black87 : Colors.black54,
        fontWeight: isMain ? FontWeight.w500 : FontWeight.normal,
      ),
    );
  }

  Widget _buildStatusTracker(Color highlightColor) {
    final steps = [
      {'label': 'Order Placed', 'icon': Icons.check, 'isComplete': true},
      {
        'label': 'Preparing',
        'icon': Icons.restaurant_menu,
        'isComplete': false,
        'isActive': true,
      },
      {
        'label': 'Ready for Pickup',
        'icon': Icons.shopping_bag,
        'isComplete': false,
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: steps.map((step) {
        final isComplete = step['isComplete'] as bool;
        final isActive =
            step.containsKey('isActive') && step['isActive'] as bool;

        Color iconColor = isComplete
            ? highlightColor
            : isActive
            ? Colors.white
            : Colors.grey.shade500;

        Color circleColor = isComplete
            ? Colors.white
            : isActive
            ? highlightColor
            : Colors.grey.shade200;

        return Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: circleColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isComplete ? highlightColor : Colors.grey.shade300,
                  width: isComplete ? 2 : 1,
                ),
              ),
              child: Center(
                child: isComplete
                    ? Icon(Icons.check, size: 32, color: highlightColor)
                    : Icon(
                        step['icon'] as IconData,
                        size: 24,
                        color: isActive ? Colors.white : Colors.grey.shade500,
                      ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: isActive ? highlightColor : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
