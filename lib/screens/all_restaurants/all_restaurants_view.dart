import 'package:flutter/material.dart';

class AllRestaurantsView extends StatelessWidget {
  const AllRestaurantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AllRestaurantsViewBody());
  }
}

class AllRestaurantsViewBody extends StatelessWidget {
  const AllRestaurantsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView();
  }
}
