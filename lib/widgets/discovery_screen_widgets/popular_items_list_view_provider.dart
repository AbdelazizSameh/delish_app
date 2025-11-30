import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/general_popular_items/general_popular_items_cubit.dart';
import 'popular_items_list_view.dart';

class PopularItemsListViewProvider extends StatelessWidget {
  const PopularItemsListViewProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenaralPopularItemsCubit()..fetchPopularItems(),
      child: const PopularItemsListView(),
    );
  }
}
