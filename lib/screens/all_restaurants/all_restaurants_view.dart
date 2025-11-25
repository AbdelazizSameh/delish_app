import 'package:delish_app/widgets/all_restaurant_screen_widget/restaurant_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app_assets.dart';
import '../../widgets/all_restaurant_screen_widget/category_card_widget.dart';
import '../../widgets/section_header.dart';

class AllRestaurantsView extends StatelessWidget {
  const AllRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xffF96234),
              child: SvgPicture.asset(AppAssets.home, width: 19, height: 19),
            ),
            SizedBox(width: 10),
            Text(
              'Home, ',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            Text('Jl. Soekarno Hatta 15A', style: TextStyle(fontSize: 14)),
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

            const SectionHeader(title: "Categories"),
            const SizedBox(height: 8),
            SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  CategoryCard(
                    item: CategoryItemModel(
                      imagePath: "assets/images/food_buger.png",
                      title: "Pizza",
                      subtitle: "30 Places",
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const SectionHeader(title: "All restaurants", seeAll: false),
            const SizedBox(height: 12),
            RestaurantCard(
              imagePath: "assets/images/food_buger.png",
              title: "Tasty Bowl",
              description: "Choose from a variety of bowl options...",
              price: 1.0,
              rating: 9.2,
              onTap: () {},
            ),
            RestaurantCard(
              imagePath: "assets/images/food_buger.png",
              title: "Tasty Bowl",
              description: "Choose from a variety of bowl options...",
              price: 1.0,
              rating: 9.2,
              onTap: () {},
            ),
            RestaurantCard(
              imagePath: "assets/images/food_buger.png",
              title: "Tasty Bowl",
              description: "Choose from a variety of bowl options...",
              price: 1.0,
              rating: 9.2,
              onTap: () {},
            ),
            RestaurantCard(
              imagePath: "assets/images/food_buger.png",
              title: "Tasty Bowl",
              description: "Choose from a variety of bowl options...",
              price: 1.0,
              rating: 9.2,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
