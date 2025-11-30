import 'package:flutter/material.dart';

import '../../models/add_on.dart';

class AddonSection extends StatelessWidget {
  final List<AddOn> addons;
  final List<bool> selected;
  final Function(int index) onToggle;

  const AddonSection({
    super.key,
    required this.addons,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Add more",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...List.generate(addons.length, (index) {
          final addon = addons[index];
          final isSel = selected[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Image.asset(addon.image, width: 40, height: 40),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    addon.name,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "+\$${addon.price.toStringAsFixed(2)}",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () => onToggle(index),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFF4400),
                        width: 2,
                      ),
                    ),
                    child: isSel
                        ? Center(
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: const BoxDecoration(
                                color: Color(0xFFFF4400),
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
