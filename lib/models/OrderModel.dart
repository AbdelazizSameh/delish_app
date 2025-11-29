import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  final String id;
  final String idforsearch;
  final String restaurantId;
  final String name;
  final String image;
  final int quantity;
  final String status;
  final double totalPrice;
  final Timestamp createdAt;

  Order({
    required this.idforsearch,
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      idforsearch: map['idforsearch'] ?? '',

      id: map['id'].toString(),
      restaurantId: map['restaurantId'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? 0,
      status: map['status'] ?? '',
      totalPrice: map['totalPrice'] ?? 0,
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
      'idforsearch': idforsearch,
    };
  }
}
