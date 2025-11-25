class AddOn {
 final String name;   // Addon Name
  final double price;  // Addon Price
   final String image; //Addon image
AddOn({required this.name, required this.price , required this.image});
}

class FoodItem {
  final String name;
  final String image; // asset path
  final double price; // current price 
  final double? oldPrice; // optional old price (for discount)
  final String description;
  final List<AddOn> addons;

  FoodItem({
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice, // optional
    required this.description,
    this.addons = const [],
  });
}


    
