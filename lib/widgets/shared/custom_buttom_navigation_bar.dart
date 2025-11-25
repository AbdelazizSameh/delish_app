import 'dart:ui';
import 'package:delish_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'nav_bar_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final void Function(int value) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 18,
      right: 18,
      height: 70,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.black.withValues(alpha: 0.25),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NavBarItem(
                  iconAsset: AppAssets.bottomNavBarDiscover,
                  label: "Discover",
                  index: 0,
                  currentIndex: currentIndex,
                  onTap: () => onTap(0),
                ),
                NavBarItem(
                  iconAsset: AppAssets.bottomNavBarRestaurants,
                  label: "Restaurants",
                  index: 1,
                  currentIndex: currentIndex,
                  onTap: () => onTap(1),
                ),
                NavBarItem(
                  iconAsset: AppAssets.bottomNavBarSearch,
                  label: "Search",
                  index: 2,
                  currentIndex: currentIndex,
                  onTap: () => onTap(2),
                ),
                NavBarItem(
                  iconAsset: AppAssets.bottomNavBarFavourite,
                  label: "Favorite",
                  index: 3,
                  currentIndex: currentIndex,
                  onTap: () => onTap(3),
                ),
                NavBarItem(
                  iconAsset: AppAssets.profile,
                  label: "Profile",
                  index: 4,
                  currentIndex: currentIndex,
                  onTap: () => onTap(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
