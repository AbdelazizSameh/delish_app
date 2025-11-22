import 'package:flutter/material.dart';
import '../../models/menu_item_model.dart';
import 'menu_item_card.dart';
import 'restaurant_header.dart';
import 'restaurant_info.dart';

class RestaurantInfoViewBody extends StatelessWidget {
  const RestaurantInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: RestaurantHeader()),
        const SliverToBoxAdapter(child: RestaurantInfo()),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              return MenuItemCard(index: index + 1, item: menuItems[index]);
            },
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
