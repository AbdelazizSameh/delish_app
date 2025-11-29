import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/items_model.dart';
import '../../models/menu_item_model.dart';
import 'menu_text.dart';

class MenuItemCard extends StatelessWidget {
  final int index;
  final ItemModel item;

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
            child: CachedNetworkImage(
              imageUrl: item.image,
              height: 100,
              width: 110,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 100,
                width: 110,
                color: Colors.grey.shade200,
                child: const Center(child: CupertinoActivityIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 100,
                width: 110,
                color: Colors.grey.shade200,
                child: const Icon(Icons.error, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
