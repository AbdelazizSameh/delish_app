import 'package:flutter/material.dart';

class FavouriteTabBar extends StatelessWidget {
  final int selectedTab;
  final Function(int) onTabSelected;

  const FavouriteTabBar({
    super.key,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Colors.black, width: 0.6),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(0),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == 0
                      ? Color(0xffF83B01)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                duration: Duration(milliseconds: 100),
                child: Text(
                  "Food Items",
                  style: TextStyle(
                    color: selectedTab == 0 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(1),
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  color: selectedTab == 1
                      ? Color(0xffF83B01)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                duration: Duration(milliseconds: 100),
                child: Text(
                  "Restaurants",
                  style: TextStyle(
                    color: selectedTab == 1 ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
