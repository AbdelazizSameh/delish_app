import 'package:delish_app/screen/Order_status.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> orderItems;
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.orderItems,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFFE65100);
    const Color highlightColor = Color(0xFFFF7043);
    const Color textColor = Colors.black87;
    const TextStyle bodyTextStyle = TextStyle(fontSize: 16, color: textColor);
    const TextStyle changeButtonStyle = TextStyle(
      color: highlightColor,
      fontWeight: FontWeight.bold,
    );

    final String formattedOrderTotal = totalAmount
        .toStringAsFixed(2)
        .replaceAll('.', ',');

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, size: 28, color: textColor),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Checkout',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: textColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildSection(
              title: 'Shipping address',
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Jane Doe', style: bodyTextStyle),
                  SizedBox(height: 4),
                  Text('3 Newbridge Court', style: bodyTextStyle),
                  Text('Chino Hills, CA 91709, Uniteds', style: bodyTextStyle),
                ],
              ),
              onChanged: () {},
              changeButtonStyle: changeButtonStyle,
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            const SizedBox(height: 20),
            _buildSection(
              title: 'Payment',
              content: Row(
                children: [
                  Container(
                    width: 30,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Icon(
                      Icons.credit_card,
                      size: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text('•••• •••• •••• 3947', style: bodyTextStyle),
                ],
              ),
              onChanged: () {},
              changeButtonStyle: changeButtonStyle,
            ),
            const SizedBox(height: 40),
            const Divider(height: 1),
            const SizedBox(height: 30),
            const Text(
              'Order Summary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 15),

            ...orderItems.map((item) {
              double itemTotal = item['price'] * item['quantity'];
              return _buildSummaryRow(
                title: '${item['quantity']}x ${item['name']}',
                value: '€${itemTotal.toStringAsFixed(2).replaceAll('.', ',')}',
              );
            }).toList(),

            const SizedBox(height: 10),
            _buildSummaryRow(
              title: 'Total',
              value:
                  '€${(totalAmount).toStringAsFixed(2).replaceAll('.', ',')}',
              isBold: true,
            ),
            const SizedBox(height: 150),
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
                builder: (context) =>
                    OrderDetailsScreen(orderItems: orderItems),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: const Size(double.infinity, 55),
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          child: const Text(
            'SUBMIT ORDER',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required Widget content,
    required VoidCallback onChanged,
    required TextStyle changeButtonStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: onChanged,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 20),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text('Change', style: changeButtonStyle),
            ),
          ],
        ),
        const SizedBox(height: 10),
        content,
      ],
    );
  }

  Widget _buildSummaryRow({
    required String title,
    required String value,
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.black : Colors.black54,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
