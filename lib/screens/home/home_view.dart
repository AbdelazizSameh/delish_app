

import 'package:delish/Screens/all_restaurants/all_restaurants_view.dart';
import 'package:delish/Screens/discovery/discovery_view.dart';
import 'package:delish/Screens/favorite/favorite_screen.dart';
import 'package:flutter/material.dart';

import '../../widgets/Global/custom_buttom_navigation_bar.dart';
import '../profile/profile_view.dart';
import '../search/search_view.dart' show SearchView;

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
    SearchView(),
    FavoriteViewProvider(),
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
