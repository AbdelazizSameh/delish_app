import 'package:delish_app/screens/restaurant_info/restaurant_info_view.dart';
import 'package:delish_app/widgets/all_restaurant_screen_widget/restaurant_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/app_assets.dart';
import '../../widgets/all_restaurant_screen_widget/category_card_widget.dart';
import '../../widgets/discovery_screen_widgets/custom_app_bar.dart';
import '../../widgets/shared/section_header.dart';

class AllRestaurantsView extends StatelessWidget {
  const AllRestaurantsView({super.key});

  static final List<CategoryItemModel> categories = [
    CategoryItemModel(
      imagePath: "assets/images/food_buger.png",
      title: "Pizza",
      subtitle: "30 Places",
    ),
    CategoryItemModel(
      imagePath: "assets/images/food_buger.png",
      title: "Burger",
      subtitle: "12 Places",
    ),
  ];

  static final List<Map<String, dynamic>> restaurants = [
    {
      "image": "assets/images/food_buger.png",
      "title": "Tasty Bowl",
      "desc": "Choose from a variety of bowl options...",
      "price": 1.0,
      "rating": 9.2,
    },
    {
      "image": "assets/images/food_buger.png",
      "title": "Burger House",
      "desc": "Fresh burgers with amazing flavors...",
      "price": 1.0,
      "rating": 8.8,
    },
    {
      "image": "assets/images/food_buger.png",
      "title": "Pizza Mania",
      "desc": "Hot fresh pizzas delivered fast...",
      "price": 1.0,
      "rating": 9.5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          CustomAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
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
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: categories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) =>
                        CategoryCard(item: categories[index]),
                  ),
                ),

                const SizedBox(height: 24),
                const SectionHeader(title: "All restaurants", seeAll: false),
                const SizedBox(height: 12),
              ]),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final r = restaurants[index];
                return RestaurantCard(
                  imagePath: r["image"],
                  title: r["title"],
                  description: r["desc"],
                  price: r["price"],
                  rating: r["rating"],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RestaurantInfoView(),
                      ),
                    );
                  },
                );
              }, childCount: restaurants.length),
            ),
          ),
        ],
      ),
    );
  }
}
