import 'package:flutter/material.dart';
import '../../widgets/restaurant_screen_widgets/restaurant_view_body.dart';

class RestaurantView extends StatelessWidget {
  const RestaurantView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RestaurantViewBody(),
    );
  }
}
