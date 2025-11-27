import 'package:delish/cubits/fastest_restaurants/fastest_restaurants_cubit.dart';
import 'package:delish/cubits/get_categories_with_count/get_categories_with_count_cubit.dart';
import 'package:delish/cubits/general_popular_items/general_popular_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/get_all_restaurants/get_all_restaurants_cubit.dart';
import '../../cubits/get_favourite_items/get_favourite_items_cubit.dart';
import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';
import '../../cubits/specific_items_for_restaurants/specific_items_for_restaurants_cubit.dart';
import 'carousel_slider_builder.dart';
import '../Global/custom_sliver_app_bar.dart';
import 'fastest_delivery_list_view.dart';
import 'popular_items_list_view.dart';
import '../Global/section_header.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FastestRestaurantsCubit>(context).fetchFastRestaurants();
    BlocProvider.of<PopularItemsCubit>(context).fetchPopularItems();
    BlocProvider.of<GetCategoriesWithCountCubit>(
      context,
    ).fetchCategoriesWithCount('1if9Yn74ix3RkGOEfEFL');
    BlocProvider.of<GetAllRestaurantsCubit>(context).fetchAllRestaurants();
    BlocProvider.of<SpecificItemsForRestaurantsCubit>(
      context,
    ).fetchSpecificItems('1if9Yn74ix3RkGOEfEFL');
    BlocProvider.of<GetFavouriteRestaurantsCubit>(
      context,
    ).fetchFavouriteRestaurants('t4nMAvE6NuOI0KvsqIc36yvSmGX2');
    BlocProvider.of<GetFavouriteItemsCubit>(
      context,
    ).fetchFavouriteItems('t4nMAvE6NuOI0KvsqIc36yvSmGX2');

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: const [
        CustomSliverAppBar(),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(child: CustomCarouselSliderBuilder()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 19),
            child: Column(
              children: [
                SectionHeader(title: "Fastest  🔥"),
                FastestDeliveryListView(),
                SectionHeader(title: "Popular items 👏"),
                PopularItemsListView(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
