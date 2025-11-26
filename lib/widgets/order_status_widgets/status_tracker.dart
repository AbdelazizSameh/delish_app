import 'package:flutter/material.dart';

class StatusTracker extends StatelessWidget {
  final Color color;

  const StatusTracker({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'label': 'Order Placed', 'icon': Icons.check, 'state': 'done'},
      {'label': 'Preparing', 'icon': Icons.restaurant_menu, 'state': 'active'},
      {
        'label': 'Ready for Pickup',
        'icon': Icons.shopping_bag,
        'state': 'idle',
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: steps.map((step) {
        String state = step['state'] as String;

        bool done = state == "done";
        bool active = state == "active";

        return Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active
                    ? color
                    : done
                    ? Colors.white
                    : Colors.grey.shade200,
                border: Border.all(
                  color: done ? color : Colors.grey.shade400,
                  width: done ? 2 : 1,
                ),
              ),
              child: Center(
                child: Icon(
                  step['icon'] as IconData,
                  size: 26,
                  color: active
                      ? Colors.white
                      : done
                      ? color
                      : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: active ? color : Colors.black87,
                fontWeight: active ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
