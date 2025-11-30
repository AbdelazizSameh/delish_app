import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delish/models/add_on.dart';

class ItemModel {
  final String id;
  final String restaurantId;
  String? categoryId;
  final String image;
  final String name;
  final String description;
  final double price;
  final double discount;
  final double priceAfterDiscount;
  final bool isPopular;
  final Timestamp createdAt;
  final List<AddOn> addons;

  ItemModel({
    this.categoryId,
    required this.id,
    required this.restaurantId,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.discount,
    required this.priceAfterDiscount,
    required this.isPopular,
    required this.createdAt,
    this.addons = const [],
  });

  factory ItemModel.fromMap(
    Map<String, dynamic> data,
    String itemId,
    String restaurantId,
    String? categoryId,
  ) {
    return ItemModel(
      id: itemId,
      restaurantId: restaurantId,
      categoryId: categoryId ?? '',
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discount: (data['discount'] ?? 0).toDouble(),
      priceAfterDiscount: (data['price_after_discount'] ?? 0).toDouble(),
      isPopular: data['isPopular'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }
}


