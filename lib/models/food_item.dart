class AddOn {
  final String name;
  final double price;
  final String image;
  AddOn({required this.name, required this.price, required this.image});
}

class FoodItem {
  final String name;
  final String image;
  final double price;
  final double? oldPrice;
  final String description;
  final List<AddOn> addons;

  final String restaurantId;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice,
    required this.description,
    this.addons = const [],
    required this.restaurantId,
  });
}
