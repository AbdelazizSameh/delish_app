import 'package:cloud_firestore/cloud_firestore.dart';

class RestaurantModel {
  final Timestamp createdAt;
  final String image;
  final bool isFast;
  final String name;
  final double rating;
  final int ratingCount;
  final String restaurnatId;

  const RestaurantModel({
    required this.restaurnatId,
    required this.createdAt,
    required this.image,
    required this.isFast,
    required this.name,
    required this.rating,
    required this.ratingCount,
  });

  factory RestaurantModel.fromMap(Map<String, dynamic> map, String docId) {
    return RestaurantModel(
      createdAt: map['createdAt'] ?? Timestamp.now(),
      image: map['image'] ?? '',
      isFast: map['isFast'] ?? false,
      name: map['name'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      ratingCount: map['ratingCount'] ?? 0,
      restaurnatId: docId,
    );
  }
}
