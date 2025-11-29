import 'package:flutter/material.dart';

class StatusTracker extends StatelessWidget {
  final Color color;
  final String status; // "placed" | "preparing" | "ready"

  const StatusTracker({super.key, required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'label': 'Order Placed', 'icon': Icons.check, 'key': 'placed'},
      {'label': 'Preparing', 'icon': Icons.restaurant_menu, 'key': 'preparing'},
      {'label': 'Ready for Pickup', 'icon': Icons.shopping_bag, 'key': 'ready'},
    ];
    int currentIndex = steps.indexWhere((s) => s['key'] == status);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: steps.asMap().entries.map((entry) {
        int index = entry.key;
        var step = entry.value;

        bool isDone = index < currentIndex;
        bool isActive = index == currentIndex;

        return Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? color
                    : isDone
                    ? Colors.white
                    : Colors.grey.shade200,
                border: Border.all(
                  color: isDone || isActive ? color : Colors.grey.shade400,
                  width: isDone || isActive ? 2 : 1,
                ),
              ),
              child: Center(
                child: Icon(
                  step['icon'] as IconData,
                  size: 26,
                  color: isActive
                      ? Colors.white
                      : isDone
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
                color: isActive ? color : Colors.black87,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
