import 'package:flutter/material.dart';

class StatusTracker extends StatelessWidget {
  final Color color;
  final String status;
  const StatusTracker({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'label': 'Order Placed', 'icon': Icons.check, 'key': 'placed'},
      {'label': 'Preparing', 'icon': Icons.restaurant_menu, 'key': 'preparing'},
      {'label': 'Ready for Pickup', 'icon': Icons.shopping_bag, 'key': 'completed'},
    ];

    int currentIndex = steps.indexWhere((s) => s['key'] == status);
    if (currentIndex == -1) currentIndex = 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: steps.map((step) {
        int index = steps.indexOf(step);
        bool isDone = index < currentIndex;
        bool isActive = index == currentIndex;

        return Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? color : isDone ? Colors.white : Colors.grey.shade200,
                border: Border.all(
                  color: isActive || isDone ? color : Colors.grey.shade400,
                  width: isActive || isDone ? 2 : 1,
                ),
              ),
              child: Center(
                child: Icon(
                  isDone ? Icons.check : step['icon'] as IconData,
                  size: 26,
                  color: isActive ? Colors.white : isDone ? color : Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              step['label'] as String,
              style: TextStyle(
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? color : Colors.black87,
                fontSize: 12,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
