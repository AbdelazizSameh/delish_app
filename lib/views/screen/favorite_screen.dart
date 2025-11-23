import 'package:delish_app/widgets/favorite_screen_widget/food_card.dart';
import 'package:delish_app/widgets/favorite_screen_widget/search_bar.dart';
import 'package:delish_app/widgets/favorite_screen_widget/tab_button.dart';
import 'package:delish_app/widgets/restaurant_screen_widget/restaurant_card_widget.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSearchBar(),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.black, width: 0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabButton(
                      
                      text: "Food Items",
                      isSelected: selectedTab == 0,
                      onTap: () => setState(() => selectedTab = 0),
                    ),
                    const SizedBox(width: 10),
                    TabButton(
                      text: "Restaurants",
                      isSelected: selectedTab == 1,
                      onTap: () => setState(() => selectedTab = 1),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (selectedTab == 0) ...[
                const FoodCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Cheese Burger',
                  subtitle: "Classic & juicy taste",
                  restaurant: 'Burger Hub',
                  time: '15-30min',
                  rating: '9.0',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Cheese Burger',
                  subtitle: "Classic & juicy taste",
                  restaurant: 'Burger Hub',
                  time: '15-30min',
                  rating: '9.0',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/food.jpg',
                  title: 'Cheese Burger',
                  subtitle: "Classic & juicy taste",
                  restaurant: 'Burger Hub',
                  time: '15-30min',
                  rating: '9.0',
                ),
              ] else ...[
                const RestaurantCard(
                  imagePath: 'assets/images/food.jpg',
                  title: 'Italian Delight',
                  description: 'Authentic Italian Cuisine',
                  price: 50.0,
                  rating: 4.8,
                ),
                const SizedBox(height: 12),
                const RestaurantCard(
                  imagePath: 'assets/images/food.jpg',
                  title: 'Sushi World',
                  description: 'Fresh Sushi and More',
                  price: 70.0,
                  rating: 4.9,
                ),
                const SizedBox(height: 12),
                const RestaurantCard(
                  imagePath: 'assets/images/food.jpg',
                  title: 'Burger Hub',
                  description: 'Classic & Juicy Burgers',
                  price: 40.5,
                  rating: 5.0,
                ),
                const SizedBox(height: 12),
                const RestaurantCard(
                  imagePath: 'assets/images/food.jpg',
                  title: 'Vegan Corner',
                  description: 'Healthy & Delicious Vegan Food',
                  price: 35.0,
                  rating: 4.7,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
