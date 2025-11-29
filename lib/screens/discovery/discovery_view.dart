import 'package:delish/cubits/general_popular_items/general_popular_items_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/fastest_restaurants/fastest_restaurants_cubit.dart';
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
    getAllRestaurantsID();
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FastestRestaurantsCubit()..fetchFastRestaurants(),
          ),
          BlocProvider(create: (context) => PopularItemsCubit()),
        ],
        child: const DiscoveryViewBody(),
      ),
    );
  }
}
