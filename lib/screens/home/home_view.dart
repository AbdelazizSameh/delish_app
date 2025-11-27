import 'package:delish/screens/favorite/favorite_screen.dart';
import 'package:delish/screens/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/fastest_restaurants/fastest_restaurants_cubit.dart';
import '../../widgets/Global/custom_buttom_navigation_bar.dart';
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
    SearchView(),
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
