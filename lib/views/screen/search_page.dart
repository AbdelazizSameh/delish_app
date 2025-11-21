import 'package:flutter/material.dart';
import 'widgets/food_item.dart';
import 'food_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

List<FoodItem> allFoods = [
  FoodItem(
    name: 'Carbonara Pasta',
    image: 'assets/images/pasta.jpg',
    price: 12.0,
    description: 'Smoked pork, Pecorino cheese, ground black pepper.',
    addons: [
      AddOn(name: 'Parmesan cheese', price: 1.0 , image: 'assets/images/parmesan cheese.jpg'),
      AddOn(name: 'Sause', price: 0.75, image: 'assets/images/Sause.jpg'),
    ],
  ),
  FoodItem(
    name: 'Burger',
    image: 'assets/images/burger.jpg',
    price: 15.0,
    description: 'Juicy beef patty with lettuce, tomato, and cheese.',
    addons: [
      AddOn(name: 'Extra cheese', price: 1.0, image: 'assets/images/exctra-cheese.jpg'),
      AddOn(name: 'Fries side', price: 2.5, image: 'assets/images/french fries.jpg'),
    ],
  ),
  FoodItem(
    name: 'Pizza',
    image: 'assets/images/pizza.jpg',
    price: 10.0,
    description: 'Tomato sauce, mozzarella, and your favorite toppings.',
    addons: [
      AddOn(name: 'Extra toppings', price: 1.5, image: 'assets/images/Extra toppings.jpg'),
      AddOn(name: 'Garlic dip', price: 0.75, image: 'assets/images/Garlic dip.jpg'),
    ],
  ),
  FoodItem(
    name: 'Salmon',
    image: 'assets/images/salmon.jpg',
    price: 20.0,
    description: 'Fresh vegetables with a light vinaigrette dressing.',
    addons: [
      AddOn(name: 'White rice', price: 2.0, image: 'assets/images/White rice.jpg'),
      AddOn(name: 'Creamy sauce', price: 1.5, image: 'assets/images/Creamy sauce.jpg'),
    ],
  ),
  FoodItem(
    name: 'Cake',
    image: 'assets/images/cake.jpg',
    price: 12.0,
    description: 'Soft sponge cake topped with cream.',
    addons: [
      AddOn(name: 'Vanilla ice cream', price: 2.0, image: 'assets/images/Vanilla ice cream.jpg'),
      AddOn(name: 'Strawberry syrup', price: 1.0, image: 'assets/images/Strawberry syrup.jpg'),
    ],
  ),
  FoodItem(
    name: 'Waffle',
    image: 'assets/images/Waffle.jpg',
    price: 9.0,
    description: 'Sweet golden waffle made with eggs, milk, and butter.',
    addons: [
      AddOn(name: 'Chocolate syrup', price: 1.0, image: 'assets/images/Chocolate syrup.webp'),
      AddOn(name: 'Fresh strawberries', price: 1.5, image: 'assets/images/Fresh strawberries.jpg'),
    ],
  ),
  FoodItem(
    name: 'Steak',
    image: 'assets/images/Steak.jpg',
    price: 25.0,
    description: 'Grilled beef steak with garlic butter.',
    addons: [
      AddOn(name: 'Mushroom sauce', price: 1.5, image: 'assets/images/Mushroom sauce.jpg'),
      AddOn(name: 'Mashed potatoes', price: 2.0, image: 'assets/images/Mashed potatoes.jpg'),
    ],
  ),
  FoodItem(
    name: 'Sushi',
    image: 'assets/images/Sushi.jpg',
    price: 13.0,
    description: 'Fresh rice rolls with salmon, avocado, and seaweed.',
    addons: [
      AddOn(name: 'Soy sauce', price: 0.75, image: 'assets/images/Soy sauce.jpg'),
      AddOn(name: 'Wasabi', price: 0.5, image: 'assets/images/Wasabi.png'),
    ],
  ),
  FoodItem(
    name: 'Taco',
    image: 'assets/images/Taco.jpg',
    price: 14.0,
    description: 'Soft tortilla with minced beef, lettuce, and cheese.',
    addons: [
      AddOn(name: 'Guacamole', price: 1.5, image: 'assets/images/Guacamole.jpg'),
      AddOn(name: 'Sour cream', price: 1.0, image: 'assets/images/Sour cream.jpg'),
    ],
  ),
  FoodItem(
    name: 'French Fries',
    image: 'assets/images/french fries.jpg',
    price: 5.0,
    description: 'Golden crispy potato fries with light salt.',
    addons: [
      AddOn(name: 'Ketchup', price: 0.5, image: 'assets/images/Ketchup.jpg'),
      AddOn(name: 'Cheese sauce', price: 1.0, image: 'assets/images/cheese sause.jpg'),
    ],
  ),
  FoodItem(
    name: 'Fried Chicken',
    image: 'assets/images/Fried chicken.jpg',
    price: 11.0,
    description: 'Crispy chicken fried to perfection.',
    addons: [
      AddOn(name: 'Spicy sauce', price: 1.0, image: 'assets/images/Spicy sauce.jpg'),
      AddOn(name: 'Coleslaw', price: 1.5, image: 'assets/images/Coleslaw.jpg'),
    ],
  ),
  FoodItem(
    name: 'Lemon Tart',
    image: 'assets/images/Lemon tart.jpg',
    price: 9.5,
    description: 'Buttery crust filled with tangy lemon cream.',
    addons: [
      AddOn(name: 'Whipped cream', price: 1.0, image: 'assets/images/Whipped cream.webp'),
      AddOn(name: 'Fresh berries', price: 1.5, image: 'assets/images/Fresh berries.jpg'),
    ],
  ),
  FoodItem(
    name: 'Pancake',
    image: 'assets/images/Pancake.jpg',
    price: 8.5,
    description: 'Fluffy pancakes made with eggs and milk.',
    addons: [
      AddOn(name: 'Maple syrup', price: 0.75, image: 'assets/images/Maple syrup.jpeg'),
      AddOn(name: 'Banana slices', price: 1.0, image: 'assets/images/Banana slices.webp'),
    ],
  ),
  FoodItem(
    name: 'Poke Bowl Fresh',
    image: 'assets/images/Poke bowl fresh.jpg',
    price: 15.0,
    description: 'Rice bowl with salmon, avocado, and sesame.',
    addons: [
      AddOn(name: 'Spicy mayo', price: 1.0, image: 'assets/images/Spicy mayo.jpg'),
      AddOn(name: 'Sesame seeds', price: 0.5, image: 'assets/images/Sesame seeds.jpg'),
    ],
  ),
  FoodItem(
    name: 'Acai Yogurt Bowl',
    image: 'assets/images/Acai Yogurt Bowl.jpg',
    price: 7.5,
    description: 'Smooth acai blended with yogurt and granola.',
    addons: [
      AddOn(name: 'Honey drizzle', price: 0.75, image: 'assets/images/Honey drizzle.jpg'),
      AddOn(name: 'Chia seeds', price: 0.5, image: 'assets/images/Chia seeds.webp'),
    ],
  ),
  FoodItem(
    name: 'Avocado and Egg Toast',
    image: 'assets/images/Avocado and Egg Toast.jpg',
    price: 11.0,
    description: 'Toasted bread with smashed avocado and poached egg.',
    addons: [
      AddOn(name: 'Chili flakes', price: 0.5, image: 'assets/images/Chili flakes.jpg'),
      AddOn(name: 'Feta cheese', price: 1.5, image: 'assets/images/Feta cheese.jpg'),
    ],
  ),
  FoodItem(
    name: 'Pasta White Sauce',
    image: 'assets/images/pasta white sause.jpg',
    price: 18.0,
    description: 'Creamy pasta with cheese and garlic sauce.',
    addons: [
      AddOn(name: 'Grilled chicken', price: 2.5, image: 'assets/images/Grilled chicken.jpg'),
      AddOn(name: 'Extra parmesan', price: 1.0, image: 'assets/images/cheese2.jpg'),
    ],
  ),
  FoodItem(
    name: 'Lasagna',
    image: 'assets/images/Lasagna.jpg',
    price: 16.5,
    description: 'Layered pasta with beef, tomato sauce, and mozzarella.',
    addons: [
      AddOn(name: 'Garlic bread', price: 1.5, image: 'assets/images/Garlic bread.jpg'),
      AddOn(name: 'Extra cheese', price: 1.0, image: 'assets/images/cheese2.jpg'),
    ],
  ),
  FoodItem(
    name: 'Shrimp',
    image: 'assets/images/shrimp.jpg',
    price: 18.7,
    description: 'Juicy shrimp sautéed with garlic butter and herbs.',
    addons: [
      AddOn(name: 'Lemon butter sauce', price: 1.0, image: 'assets/images/Lemon butter sauce.jpg'),
      AddOn(name: 'White rice', price: 1.5, image: 'assets/images/White rice.jpg'),
    ],
  ),
  FoodItem(
    name: 'Tiramisu',
    image: 'assets/images/tiramisu.jpg',
    price: 17.9,
    description: 'Classic Italian dessert with coffee and mascarpone.',
    addons: [
      AddOn(name: 'Cocoa powder', price: 0.5, image: 'assets/images/Cocoa powder.jpg'),
      AddOn(name: 'Chocolate flakes', price: 1.0, image: 'assets/images/Chocolate flakes.jpg'),
    ],
  ),
  FoodItem(
    name: 'Breaded Chicken',
    image: 'assets/images/Breaded chicken.jpg',
    price: 18.4,
    description: 'Crispy breaded chicken fillet made with seasoned crumbs.',
    addons: [
      AddOn(name: 'Honey mustard sauce', price: 1.0, image: 'assets/images/Honey mustard sauce.jpg'),
      AddOn(name: 'Fries', price: 2.0, image: 'assets/images/french fries.jpg'),
    ],
  ),
];
  String query = '';
  int _currentIndex = 2; // search page selected by default,assets/images/.jpg

  @override
  Widget build(BuildContext context) {
    final filtered = allFoods
        .where((f) => f.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => query = v),
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Food items grid
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (var f in filtered.isEmpty ? allFoods : filtered)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FoodDetailsPage(food: f),
                              ),
                            );
                          },
                          child: Container(
                            width: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.08),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Food image
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                  child: f.image.isNotEmpty
                                      ? Image.asset(
                                          f.image,
                                          fit: BoxFit.cover,
                                          height: 100,
                                          width: double.infinity,
                                        )
                                      : Container(
                                          height: 100,
                                          color: Colors.grey[200],
                                          child: const Icon(Icons.fastfood,
                                              size: 40, color: Colors.grey),
                                        ),
                                ),
                                const SizedBox(height: 8),
                                // Food name
                                Text(
                                  f.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 19,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                // Food price
                                Text(
                                  '\$${f.price.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    color: Color(0xFFFF4400),
                                    fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            // TODO: Add navigation logic here
          });
        },
        selectedItemColor: const Color(0xFFF64F1D),
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}