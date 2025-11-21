import 'package:delish_app/screens/profile/profile_view.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_buttom_navigation_bar.dart';
import '../../widgets/discovery_screen_widgets/discovery_view_body.dart';
import '../restaurant/restaurant_view.dart';

class DiscoveryView extends StatefulWidget {
  const DiscoveryView({super.key});

  @override
  State<DiscoveryView> createState() => _DiscoveryViewState();
}

class _DiscoveryViewState extends State<DiscoveryView> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DiscoveryViewBody(),
    RestaurantView(),
    Center(child: Text('Search')),
    Center(child: Text('Favorite')),
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
