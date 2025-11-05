import 'package:flutter/material.dart';

import '../models/fastest_delivery_model.dart';
import 'fastest_delivery_card.dart';

class FastestDeliveryListView extends StatelessWidget {
  const FastestDeliveryListView({super.key, required this.items});

  final List<FastestDeliveryModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) =>
            FastestDeliveryCard(deliveryItem: items[index]),
      ),
    );
  }
}
