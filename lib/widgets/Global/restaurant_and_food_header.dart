import 'package:flutter/material.dart';
import 'app_round_icon.dart';
import 'header_image.dart';

class RestaurantAndFoodHeader extends StatelessWidget {
  const RestaurantAndFoodHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HeaderImage(),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRoundIcon(
                  icon: Icons.arrow_back,
                  onTap: () => Navigator.pop(context),
                ),
                AppRoundIcon(icon: Icons.more_horiz),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
