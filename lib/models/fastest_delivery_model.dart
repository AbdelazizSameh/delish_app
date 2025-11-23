class FastestDeliveryModel {
  final String imageUrl;
  final String title;
  final String description;
  final String price;
  final String rating;

  const FastestDeliveryModel({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
  });

  factory FastestDeliveryModel.fromJson(Map<String, dynamic> json) {
    return FastestDeliveryModel(
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      rating: json['rating'] ?? '',
    );
  }
}
