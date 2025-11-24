import 'package:delish_app/screens/favorite/favorite_screen.dart';
import 'package:delish_app/screens/restaurant_info/restaurant_info_view.dart';
import 'package:delish_app/widgets/restaurant_info_screen_widgets/restaurant_info.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_buttom_navigation_bar.dart';
import '../all_restaurants/all_restaurants_view.dart';
import '../discovery/discovery_view.dart';
import '../profile/profile_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DiscoveryView(),
    AllRestaurantsView(),
    RestaurantInfoView(),
    FavoriteView(),
    ProfileView(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(index: _selectedIndex, children: _pages),
          CustomBottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ],
      ),
    );
  }
}
