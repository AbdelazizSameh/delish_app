import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/get_favourite_items/get_favourite_items_cubit.dart';
import '../../widgets/favorite_screen_widget/food_card.dart';
import '../food_details/food_details_view.dart';

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
