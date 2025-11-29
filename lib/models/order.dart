import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String? id;
  final String restaurantId;
  final String name;
  final String image;
  final int quantity;
  String? status;
  final double totalPrice;
  final Timestamp createdAt;

  Order({
    this.id,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.quantity,
    this.status,
    required this.totalPrice,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'].toString(),
      restaurantId: map['restaurantId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? 0,
      status: map['status'] ?? '',
      totalPrice: map['totalPrice'] ?? 0.0,
      createdAt: map['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'restaurantId': restaurantId,
      'name': name,
      'image': image,
      'quantity': quantity,
      'status': status,
      'totalPrice': totalPrice,
      'createdAt': createdAt,
    };
  }
}
