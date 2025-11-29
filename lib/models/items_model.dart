import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  final String id;
  final String image;
  final String name;
  final String description;
  final double price;
  final double discount;
  final double priceAfterDiscount;
  final bool isPopular;
  final Timestamp createdAt;

  ItemModel({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.isPopular,
    required this.createdAt,
  });

  factory ItemModel.fromMap(Map<String, dynamic> data, String documentId) {
    return ItemModel(
      id: documentId,
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discount: (data['discount'] ?? 0).toDouble(),
      priceAfterDiscount: (data['priceAfterDiscount'] ?? 0).toDouble(),
      isPopular: data['isPopular'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}
