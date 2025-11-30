import 'package:delish/cubits/fav_restaurant_and_item/fav_restaurant_and_item_cubit.dart';
import 'package:delish/models/restaurants_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_messenger.dart';
import '../Global/add_favourite_widget.dart';
import 'info_tile.dart';

class RestaurantInfo extends StatelessWidget {
  const RestaurantInfo({super.key, required this.model, required this.userId});

  final RestaurantModel model;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                model.name,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              BlocBuilder<FavRestaurantAndItemCubit, FavRestaurantAndItemState>(
                builder: (context, state) {
                  bool isFav = false;
                  if (state is FavRestaurantAndItemLoaded) {
                    isFav = state.favoriteRestaurants.contains(
                      model.restaurnatId,
                    );
                  }

                  return AddFavouriteWidget(
                    isFavorite: isFav,
                    onFavTap: () async {
                      final cubit = context.read<FavRestaurantAndItemCubit>();

                      final wasFav =
                          cubit.state is FavRestaurantAndItemLoaded &&
                          (cubit.state as FavRestaurantAndItemLoaded)
                              .favoriteRestaurants
                              .contains(model.restaurnatId);

                      await cubit.toggleFavorite(
                        userId: userId,
                        type: 'restaurant',
                        id: model.restaurnatId,
                        name: model.name,
                      );

                      if (context.mounted) {
                        if (wasFav) {
                          AppMessenger.success(
                            context,
                            "Removed from favorites!",
                          );
                        } else {
                          AppMessenger.success(context, "Added to favorites!");
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "An authentic Italian touch and delicious!",
            style: TextStyle(color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          InfoTile(icon: Icons.star, text: "Excellent ${model.rating}"),
          const SizedBox(height: 70),
          const Text(
            "Popular items 🔥",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
