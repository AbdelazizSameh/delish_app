import 'package:delish/screens/food_details/food_details_view.dart';
import 'package:delish/widgets/discovery_screen_widgets/popular_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/general_popular_items/general_popular_items_cubit.dart';

class PopularItemsListView extends StatelessWidget {
  const PopularItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenaralPopularItemsCubit, GenaralPopularItemsState>(
      builder: (context, state) {
        if (state is GenaralPopularItemsLoadingState) {
          return const SizedBox(
            height: 200,
            child: Center(child: CupertinoActivityIndicator()),
          );
        }

        if (state is GenaralPopularItemsFailureState) {
          return const SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "Failed to load the items",
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is GenaralPopularItemsLoadedState) {
          final items = state.items;
          return SizedBox(
            height: 200,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FoodDetailsView(food: items[index]),
                      ),
                    );
                  },
                  child: PopularItem(item: items[index]),
                );
              },
            ),
          );
        }

        return const SizedBox(height: 200);
      },
    );
  }
}
