import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String type;
  final String rating;
  final String time;

  const RestaurantCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.type,
    required this.rating,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 14,
                  child: Icon(Icons.favorite, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  type,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 16,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 4),
                    Text(time, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 8),
                    const Icon(Icons.star, size: 16, color: Colors.orange),
                    Text(rating, style: const TextStyle(fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
