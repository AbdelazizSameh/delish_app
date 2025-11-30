import 'package:delish/Screens/food_details/food_details_view.dart';
import 'package:delish/cubits/get_favourite_items/get_favourite_items_cubit.dart';
import 'package:delish/widgets/favorite_screen_widget/food_card.dart';
import 'package:delish/widgets/Global/search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';
import '../restaurant_info/restaurant_info_view.dart';

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
  final search = TextEditingController();
  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  @override
  void initState() {
    super.initState();
    context.read<GetFavouriteItemsCubit>().fetchFavouriteItems(userId);
    context.read<GetFavouriteRestaurantsCubit>().fetchFavouriteRestaurants(
      userId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const CustomSearchBar(),

              const SizedBox(height: 20),

              FavouriteTabBar(
                selectedTab: selectedTab,
                onTabSelected: (v) => setState(() => selectedTab = v),
              ),

              const SizedBox(height: 20),

              selectedTab == 0
                  ? FavouriteFoodList(search: search.text)
                  : FavouriteRestaurantList(search: search.text),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class FavouriteRestaurantList extends StatelessWidget {
  final String search;

  const FavouriteRestaurantList({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      GetFavouriteRestaurantsCubit,
      GetFavouriteRestaurantsState
    >(
      builder: (context, state) {
        if (state is GetFavouriteRestaurantsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is GetFavouriteRestaurantsLoaded) {
          if (state.restaurants.isEmpty) {
            return const Text("No favourite restaurants found.");
          }

          return Column(
            children: state.restaurants.map((rest) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RestaurantInfoView(model: rest),
                  ),
                ),
                child: FoodCard(
                  imageUrl: rest.image,
                  title: rest.name,
                  subtitle: "",
                  restaurant: rest.restaurnatId,
                  time: "20-40 min",
                  rating: rest.rating,
                ),
              );
            }).toList(),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class FavouriteFoodList extends StatelessWidget {
  final String search;

  const FavouriteFoodList({super.key, required this.search});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavouriteItemsCubit, GetFavouriteItemsState>(
      builder: (context, state) {
        if (state is GetFavouriteItemsLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is GetFavouriteItemsLoaded) {
          if (state.items.isEmpty) {
            return const Text("No favourite items found.");
          }

          return Column(
            children: state.items.map((item) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => FoodDetailsView(food: item),
                  ),
                ),
                child: FoodCard(
                  imageUrl: item.image,
                  title: item.name,
                  subtitle: item.description,
                  restaurant: item.restaurantId,
                  time: "20-50 min",
                  price: item.price,
                ),
              );
            }).toList(),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class FavouriteTabBar extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  const FavouriteTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black, width: 0.6),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(0),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == 0
                      ? Color(0xffF83B01)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                duration: Duration(milliseconds: 100),
                child: Text(
                  "Food Items",
                  style: TextStyle(
                    color: selectedTab == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(1),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == 1
                      ? Color(0xffF83B01)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                duration: Duration(milliseconds: 100),
                child: Text(
                  "Restaurants",
                  style: TextStyle(
                    color: selectedTab == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
