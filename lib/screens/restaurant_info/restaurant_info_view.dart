import 'package:delish/models/restaurants_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/specific_items_for_restaurants/specific_items_for_restaurants_cubit.dart';
import '../../widgets/restaurant_info_screen_widgets/restaurant_info_view_body.dart';

class RestaurantInfoView extends StatelessWidget {
  const RestaurantInfoView({super.key, required this.model});
  final RestaurantModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SpecificItemsForRestaurantsCubit(),
        child: RestaurantInfoViewBody(restaurantModel: model),
      ),
    );
  }
}
