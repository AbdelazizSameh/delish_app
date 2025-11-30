import 'package:delish/widgets/checkout_screen_widgets/header.dart';
import 'package:flutter/material.dart';

class ShippingSection extends StatelessWidget {
  const ShippingSection({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 16, color: Colors.black87);
    const changeStyle = TextStyle(
      color: Color(0xFFFF7043),
      fontWeight: FontWeight.bold,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Header(title: 'Shipping address', onChange: () {}),
        const SizedBox(height: 10),
        const Text('Jane Doe', style: textStyle),
        const SizedBox(height: 4),
        const Text('3 Newbridge Court', style: textStyle),
        const Text('Chino Hills, CA 91709', style: textStyle),
      ],
    );
  }
}
