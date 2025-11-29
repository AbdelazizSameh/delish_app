import 'package:delish/cubits/get_favourite_items/get_favourite_items_cubit.dart';
import 'package:delish/widgets/favorite_screen_widget/food_card.dart';
import 'package:delish/widgets/Global/search_bar.dart';
import 'package:delish/widgets/favorite_screen_widget/tab_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';

class FavoriteViewProvider extends StatelessWidget {
  const FavoriteViewProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetFavouriteItemsCubit()),
        BlocProvider(create: (context) => GetFavouriteRestaurantsCubit()),
      ],
      child: Builder(
        builder: (context) {
          return const FavoriteView();
        },
      ),
    );
  }
}

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  int selectedTab = 0;
  final userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetFavouriteItemsCubit>(
      context,
    ).fetchFavouriteItems(userId);
    BlocProvider.of<GetFavouriteRestaurantsCubit>(
      context,
    ).fetchFavouriteRestaurants(userId);
  }

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

              buildTabs(),

              const SizedBox(height: 20),

              selectedTab == 0
                  ? buildFavouriteItems()
                  : buildFavouriteRestaurants(),

              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTabs() {
    return Container(
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
    );
  }

  Widget buildFavouriteItems() {
    return BlocBuilder<GetFavouriteItemsCubit, GetFavouriteItemsState>(
      builder: (context, state) {
        if (state is GetFavouriteItemsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetFavouriteItemsLoaded) {
          final items = state.items;

          if (items.isEmpty) {
            return const Text("No favourite food items found.");
          }

          return Column(
            children: items.map((item) {
              return FoodCard(
                imageUrl:
                    item["image"] ??
                    "https://png.pngtree.com/png-vector/20221125/ourlarge/pngtree-no-image-available-icon-flatvector-illustration-pic-design-profile-vector-png-image_40966566.jpg",
                title: item["name"],
                subtitle: item["description"] ?? "",
                restaurant: item["restaurantName"] ?? "",
                time: "20-50 min",
                rating: item["rating"]?.toString() ?? "0",
              );
            }).toList(),
          );
        }

        if (state is GetFavouriteItemsFailure) {
          return Text("Error: ${state.message}");
        }

        return const SizedBox();
      },
    );
  }

  Widget buildFavouriteRestaurants() {
    return BlocBuilder<
      GetFavouriteRestaurantsCubit,
      GetFavouriteRestaurantsState
    >(
      builder: (context, state) {
        if (state is GetFavouriteRestaurantsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GetFavouriteRestaurantsLoaded) {
          final restaurants = state.restaurants;

          if (restaurants.isEmpty) {
            return const Text("No favourite restaurants found.");
          }

          return Column(
            children: restaurants.map((rest) {
              return FoodCard(
                imageUrl:
                    rest["image"] ??
                    'https://png.pngtree.com/png-vector/20221125/ourlarge/pngtree-no-image-available-icon-flatvector-illustration-pic-design-profile-vector-png-image_40966566.jpg',
                title: rest["name"],
                subtitle: rest["description"] ?? "",
                restaurant: rest["type"] ?? "",
                time: "20-40 min",
                rating: rest["rating"]?.toString() ?? "0",
              );
            }).toList(),
          );
        }

        if (state is GetFavouriteRestaurantsFailure) {
          return Text("Error: ${state.message}");
        }

        return const SizedBox();
      },
    );
  }
}
