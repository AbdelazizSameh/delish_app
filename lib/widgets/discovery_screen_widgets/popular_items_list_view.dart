import 'package:delish/cubits/general_popular_items/general_popular_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/popular_item_model.dart';
import 'popular_item.dart';

class PopularItemsListView extends StatelessWidget {
  const PopularItemsListView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PopularItemsCubit>(context).fetchPopularItems();
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
