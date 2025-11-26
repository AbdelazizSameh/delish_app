import 'package:flutter/material.dart';
import 'recommendation_card.dart';

class RecommendationsList extends StatelessWidget {
  final List<Map<String, dynamic>> recommendations;

  const RecommendationsList({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: recommendations.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final rec = recommendations[index];
          return RecommendationCard(
            name: rec['name'],
            price: rec['price'],
            imageUrl: rec['imageUrl'],
          );
        },
      ),
    );
  }
}
