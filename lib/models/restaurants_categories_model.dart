class RestaurantsCategoriesModel {
  final String categoryId;
  final String name;
  final String image;
  final int itemCount;

  const RestaurantsCategoriesModel({
    required this.categoryId,
    required this.name,
    required this.image,
    required this.itemCount,
  });

  factory RestaurantsCategoriesModel.fromJson(Map<String, dynamic> json) {
    return RestaurantsCategoriesModel(
      categoryId: json['categoryId'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      itemCount: json['itemCount'] ?? 0,
    );
  }
}
