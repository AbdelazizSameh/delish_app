import 'package:flutter/material.dart';
import '../../models/menu_item_model.dart';
import 'menu_text.dart';

class MenuItemCard extends StatelessWidget {
  final int index;
  final MenuItemModel item;

  const MenuItemCard({super.key, required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: MenuText(index: index, item: item),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image,
              height: 100,
              width: 110,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
