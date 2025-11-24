import 'package:delish_app/widgets/all_restaurant_screen_widget/restaurant_card_widget.dart';
import 'package:flutter/material.dart';

import '../../widgets/all_restaurant_screen_widget/category_card_widget.dart';

class AllRestaurantsView extends StatelessWidget {
  const AllRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.home_rounded, color: Colors.orange),
              onPressed: () {},
            ),
            const SizedBox(width: 10),
            const Text(
              'Home, ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Jl. Soekarno Hatta 15A',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              "Restaurants",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Categories",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "See all",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  CategoryCard(
                    item: CategoryItemModel(
                      imagePath: "assets/images/food.jpg",
                      title: "برغر",
                      subtitle: "25 مطعم",
                    ),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    item: CategoryItemModel(
                      imagePath: "assets/images/food.jpg",
                      title: "بيتزا",
                      subtitle: "30 مطعم",
                    ),
                  ),
                  const SizedBox(width: 12),
                  CategoryCard(
                    item: CategoryItemModel(
                      imagePath: "assets/images/food.jpg",
                      title: "مشاوي",
                      subtitle: "18 مطعم",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "All restaurants",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            RestaurantCard(
              imagePath: "assets/images/food.jpg",
              title: "Tasty Bowl",
              description: "Choose from a variety of bowl options...",
              price: 1.0,
              rating: 9.2,
              onTap: () {},
            ),
            RestaurantCard(
              imagePath: "assets/images/food.jpg",
              title: "Green Salad",
              description: "Fresh and healthy salad options...",
              price: 2.5,
              rating: 8.7,
              onTap: () {},
            ),
            RestaurantCard(
              imagePath: "assets/images/food.jpg",
              title: "Italian Pasta",
              description: "Authentic Italian pasta dishes...",
              price: 3.0,
              rating: 9.0,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

}
