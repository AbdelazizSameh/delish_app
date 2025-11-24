import 'package:flutter/material.dart';
import '../../widgets/restaurant_info_screen_widgets/restaurant_info_view_body.dart';

class RestaurantInfoView extends StatelessWidget {
  const RestaurantInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: RestaurantInfoViewBody());
  }
}
