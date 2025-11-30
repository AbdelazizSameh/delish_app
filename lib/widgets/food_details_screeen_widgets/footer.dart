import 'package:flutter/material.dart';
import '../../models/order.dart';

class Footer extends StatelessWidget {
  final Order order;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback onAddToOrder;

  const Footer({
    super.key,
    required this.order,
    required this.onAdd,
    required this.onRemove,
    required this.onAddToOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 120,
          decoration: BoxDecoration(
            color: const Color(0xFFFFE6D5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.remove_circle, color: Color(0xFFFF4400)),
              ),

              Text(
                '${order.quantity}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              IconButton(
                onPressed: onAdd,
                icon: const Icon(Icons.add_circle, color: Color(0xFFFF4400)),
              ),
            ],
          ),
        ),

        ElevatedButton(
          onPressed: onAddToOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFFF4400),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 9),
          ),
          child: const Text(
            "Add to order",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
