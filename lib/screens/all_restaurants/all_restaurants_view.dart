import 'package:delish/cubits/get_categories_with_count/get_categories_with_count_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/all_restaurant_screen_widget/category_card_widget.dart';
import '../../widgets/all_restaurant_screen_widget/restaurant_card_widget.dart';
import '../../widgets/Global/custom_sliver_app_bar.dart';
import '../../widgets/Global/section_header.dart';
import '../restaurant_info/restaurant_info_view.dart';

class AllRestaurantsView extends StatelessWidget {
  const AllRestaurantsView({super.key});

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

      body: BlocProvider(
        create: (context) =>
            GetCategoriesWithCountCubit()..fetchCategoriesWithCount(),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            CustomSliverAppBar(),
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

                  BlocBuilder<
                    GetCategoriesWithCountCubit,
                    GetCategoriesWithCountState
                  >(
                    builder: (context, state) {
                      if (state is GetCategoriesWithCountLoadedState) {
                        return SizedBox(
                          height: 160,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.categories.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 12),
                            itemBuilder: (context, index) =>
                                CategoryCard(item: state.categories[index]),
                          ),
                        );
                      } else if (state is GetCategoriesWithCountLoadingState) {
                        return const SizedBox(
                          height: 160,
                          child: Center(child: CupertinoActivityIndicator()),
                        );
                      } else {
                        return const SizedBox(
                          height: 160,
                          child: Center(
                            child: Text("Failed to load Categories"),
                          ),
                        );
                      }
                    },
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
      ),
    );
  }
}
