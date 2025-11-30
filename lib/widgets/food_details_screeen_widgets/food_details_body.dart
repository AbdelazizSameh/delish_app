import 'package:delish/models/items_model.dart';
import 'package:flutter/material.dart';
import 'add_on_section.dart';
import 'description.dart';
import 'package_option.dart';
import 'prices_widget.dart';
import 'title_and_favourite.dart';

class FoodDetailsBody extends StatelessWidget {
  final ItemModel food;
  final bool isFavorite;
  final List<bool> addonSelected;
  final bool addPackage;

  final VoidCallback onToggleFavorite;
  final Function(int) onToggleAddon;
  final VoidCallback onTogglePackage;

  const FoodDetailsBody({
    super.key,
    required this.food,
    required this.isFavorite,
    required this.addonSelected,
    required this.addPackage,
    required this.onToggleFavorite,
    required this.onToggleAddon,
    required this.onTogglePackage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Only one TitleAndFavorite here
          TitleAndFavorite(
            isFavorite: isFavorite,
            onFavTap: onToggleFavorite,
            name: food.name,
          ),

          const SizedBox(height: 10),
          Description(text: food.description),

          const SizedBox(height: 12),
          Prices(price: food.price),

          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 10),

          if (food.addons.isNotEmpty)
            AddonSection(
              addons: food.addons,
              selected: addonSelected,
              onToggle: onToggleAddon,
            ),

          const SizedBox(height: 20),
          PackageOption(selected: addPackage, onTap: onTogglePackage),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
