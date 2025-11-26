import 'package:flutter/material.dart';

import '../Global/add_favourite_widget.dart';

class TitleAndFavorite extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onFavTap;
  final String name;

  const TitleAndFavorite({
    super.key,
    required this.isFavorite,
    required this.onFavTap,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        AddFavouriteWidget(onFavTap: onFavTap, isFavorite: isFavorite),
      ],
    );
  }
}
