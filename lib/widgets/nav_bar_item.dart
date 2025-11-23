import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarItem extends StatelessWidget {
  final String iconAsset;
  final String label;
  final int index;
  final int currentIndex;
  final VoidCallback onTap;

  const NavBarItem({
    super.key,
    required this.iconAsset,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = index == currentIndex;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            child: SvgPicture.asset(
              iconAsset,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.deepOrangeAccent : Colors.black,
                BlendMode.srcIn,
              ),
            ),
          ),

          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
              color: isSelected ? Colors.deepOrangeAccent : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
