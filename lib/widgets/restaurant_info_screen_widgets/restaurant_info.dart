import 'package:delish_app/widgets/shared/add_favourite_widget.dart';
import 'package:flutter/material.dart';

import 'info_tile.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "La Pasta House",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              AddFavouriteWidget(onFavTap: () {}, isFavorite: false),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "An authentic Italian touch and delicious!",
            style: TextStyle(color: Colors.grey.shade600),
          ),

          const SizedBox(height: 12),

          const InfoTile(icon: Icons.star, text: "Excellent 9.5"),

          const SizedBox(height: 70),

          const Text(
            "Popular items 🔥",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
