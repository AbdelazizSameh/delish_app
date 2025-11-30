class FoodOrderDetailsModel {
  final String name;
  final String image;
  final int quantity;
  final String restaurantId;
  final String status;
  final double totalPrice;

  FoodOrderDetailsModel({
    required this.name,
    required this.image,
    required this.quantity,
    required this.restaurantId,
    required this.status,
    required this.totalPrice,
  });

  factory FoodOrderDetailsModel.fromMap(Map<String, dynamic> map) {
    return FoodOrderDetailsModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? 0,
      restaurantId: map['restaurantId'] ?? '',
      status: map['status'] ?? '',
      totalPrice: (map['totalPrice'] ?? 0).toDouble(),
    );
  }
}
