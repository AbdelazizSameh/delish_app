import 'package:flutter/material.dart';

class SimpleDotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final double dotSize;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final Duration animationDuration;

  const SimpleDotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    this.dotSize = 10.0,
    this.spacing = 16,
    this.activeColor = const Color(0xff0B0C17),
    this.inactiveColor = const Color(0xffB6B7C0),
    this.animationDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dotSize + 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final isActive = index == currentIndex;
          return AnimatedContainer(
            duration: animationDuration,
            margin: EdgeInsets.symmetric(horizontal: spacing / 2),
            width: dotSize,
            height: dotSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? activeColor
                  : inactiveColor.withValues(alpha: 0.6),
            ),
          );
        },
      ),
    );
  }
}

