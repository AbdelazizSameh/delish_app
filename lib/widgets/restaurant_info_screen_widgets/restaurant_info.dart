import 'package:delish/models/restaurants_model.dart';
import 'package:flutter/material.dart';

import '../Global/add_favourite_widget.dart';
import 'info_tile.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({super.key, required this.model});
  final RestaurantModel model;
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
              Text(
                model.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
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

          InfoTile(icon: Icons.star, text: "Excellent ${model.rating}"),

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
