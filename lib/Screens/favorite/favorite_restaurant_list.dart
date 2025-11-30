import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';
import '../../widgets/favorite_screen_widget/food_card.dart';
import '../restaurant_info/restaurant_info_view.dart';

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
