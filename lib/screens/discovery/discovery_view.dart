import 'package:delish/cubits/get_all_restaurants/get_all_restaurants_cubit.dart';
import 'package:delish/cubits/get_categories_with_count/get_categories_with_count_cubit.dart';
import 'package:delish/cubits/general_popular_items/general_popular_items_cubit.dart';
import 'package:delish/cubits/get_favourite_items/get_favourite_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/fastest_restaurants/fastest_restaurants_cubit.dart';
import '../../cubits/get_favourite_restaurants/get_favourite_restaurants_cubit.dart';
import '../../cubits/specific_items_for_restaurants/specific_items_for_restaurants_cubit.dart';
import '../../models/user_model.dart';
import '../../utils/general_functions.dart';
import '../../widgets/discovery_screen_widgets/discovery_view_body.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    getCurrentUserInfo().then((userInfo) {
      if (userInfo != null) {
        userModel = UserModel.fromJson(userInfo);
        print('User name: ${userModel!.name}');
      } else {
        print('No user logged in');
      }
    });
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => FastestRestaurantsCubit()),
          BlocProvider(create: (context) => PopularItemsCubit()),
          BlocProvider(create: (context) => GetCategoriesWithCountCubit()),
          BlocProvider(create: (context) => GetAllRestaurantsCubit()),
          BlocProvider(create: (context) => SpecificItemsForRestaurantsCubit()),
          BlocProvider(create: (context) => GetFavouriteRestaurantsCubit()),
          BlocProvider(create: (context) => GetFavouriteItemsCubit()),
        ],
        child: const DiscoveryViewBody(),
      ),
    );
  }
}
