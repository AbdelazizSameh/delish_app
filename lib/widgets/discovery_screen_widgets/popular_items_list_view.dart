import 'package:flutter/material.dart';
import '../../models/popular_item_model.dart';
import 'popular_item.dart';

class PopularItemsListView extends StatelessWidget {
  const PopularItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return PopularItem(item: foodItems[index]);
        },
      ),
    );
  }
}
