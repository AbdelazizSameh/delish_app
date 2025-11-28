class FastestDeliveryModel {
  final String imageUrl;
  final String name;
  final String description;
  final double rating;

  const FastestDeliveryModel({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rating,
  });

  factory FastestDeliveryModel.fromJson(json) {
    return FastestDeliveryModel(
      imageUrl: json['image'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      rating: json['rating'] ?? 0.0,
    );
  }
}
