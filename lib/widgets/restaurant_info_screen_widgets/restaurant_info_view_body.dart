import 'package:delish/Services/firebase/Addfunctions/Addfunctions.dart';
import 'package:delish/cubits/fav_restaurant_and_item/fav_restaurant_and_item_cubit.dart';
import 'package:delish/models/restaurants_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/specific_items_for_restaurants/specific_items_for_restaurants_cubit.dart';
import '../../screens/food_details/food_details_view.dart';
import 'menu_item_card.dart';
import '../Global/restaurant_and_food_header.dart';
import 'restaurant_info.dart';

class RestaurantInfoViewBody extends StatefulWidget {
  const RestaurantInfoViewBody({super.key, required this.restaurantModel});
  final RestaurantModel restaurantModel;

  @override
  State<RestaurantInfoViewBody> createState() => _RestaurantInfoViewBodyState();
}

class _RestaurantInfoViewBodyState extends State<RestaurantInfoViewBody> {
  var userId = '';
  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    context.read<SpecificItemsForRestaurantsCubit>().fetchSpecificItems(
      widget.restaurantModel.restaurnatId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: RestaurantAndFoodHeader(image: widget.restaurantModel.image),
        ),
        SliverToBoxAdapter(
          child: BlocProvider(
            create: (_) =>
                FavRestaurantAndItemCubit(firestoreService: FirestoreService())
                  ..loadFavorites(userId),
            child: RestaurantInfo(
              model: widget.restaurantModel,
              userId: userId,
            ),
          ),
        ),

        BlocBuilder<
          SpecificItemsForRestaurantsCubit,
          SpecificItemsForRestaurantsState
        >(
          builder: (context, state) {
            if (state is SpecificItemsLoading) {
              return const SliverToBoxAdapter(
                child: Center(child: CupertinoActivityIndicator()),
              );
            }

            if (state is SpecificItemsFailure) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.message)),
              );
            }

            if (state is SpecificItemsLoaded) {
              final items = state.items;

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.separated(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailsView(food: items[index]),
                          ),
                        );
                      },
                      child: MenuItemCard(index: index + 1, item: item),
                    );
                  },
                  separatorBuilder: (_, __) =>
                      const Divider(height: 0, thickness: 0.5),
                ),
              );
            }

            return const SliverToBoxAdapter();
          },
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
