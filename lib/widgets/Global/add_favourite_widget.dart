import 'package:flutter/material.dart';

class AddFavouriteWidget extends StatelessWidget {
  const AddFavouriteWidget({
    super.key,
    required this.onFavTap,
    required this.isFavorite,
  });

  final VoidCallback onFavTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFavTap,
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: const Color(0xFFFF4400),
        size: 30,
      ),
    );
  }
}
