import 'package:delish/cubits/get_all_restaurants/get_all_restaurants_cubit.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GetCategoriesWithCountCubit()..fetchCategoriesWithCount(),
          ),
          BlocProvider(
            create: (context) =>
                GetAllRestaurantsCubit()..fetchAllRestaurants(),
          ),
        ],

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
              padding: const EdgeInsets.only(bottom: 90, left: 16, right: 16),
              sliver:
                  BlocBuilder<GetAllRestaurantsCubit, GetAllRestaurantsState>(
                    builder: (context, state) {
                      if (state is GetAllRestaurantsLoadedState) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return RestaurantCard(
                              restaurantModel: state.restaurants[index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => RestaurantInfoView(
                                      model: state.restaurants[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          }, childCount: state.restaurants.length),
                        );
                      } else if (state is GetAllRestaurantsLoadingState) {
                        return SliverToBoxAdapter(
                          child: const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text("Failed to load restauraunts"),
                          ),
                        );
                      }
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
