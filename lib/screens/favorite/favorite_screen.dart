import 'package:delish_app/widgets/favorite_screen_widget/food_card.dart';
import 'package:delish_app/widgets/shared/search_bar.dart';
import 'package:delish_app/widgets/favorite_screen_widget/tab_button.dart';
import 'package:delish_app/widgets/all_restaurant_screen_widget/restaurant_card_widget.dart';
import 'package:flutter/material.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
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
                width: double.infinity,
                height: 50,
                padding: const EdgeInsets.all(3),
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
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
                const FoodCard(
                  imageUrl: 'assets/images/crausel_back.png',
                  title: 'Shrimp pizza',
                  subtitle: "A seafood lover's dream",
                  restaurant: 'Crazy Pizza spot',
                  time: '20-50min',
                  rating: '8.7',
                ),
                const SizedBox(height: 12),
              ],
              const FoodCard(
                imageUrl: 'assets/images/crausel_back.png',
                title: 'Shrimp pizza',
                subtitle: "A seafood lover's dream",
                restaurant: 'Crazy Pizza spot',
                time: '20-50min',
                rating: '8.7',
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
