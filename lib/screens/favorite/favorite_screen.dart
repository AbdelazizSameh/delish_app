import 'package:delish/cubits/get_favourite_items/get_favourite_items_cubit.dart';
import 'package:delish/widgets/Global/search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';
import 'favorite_food_list.dart';
import 'favorite_restaurant_list.dart';
import 'favourite_tab_bar.dart';

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
