import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const OrderCard({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffFFF1E7),
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}
