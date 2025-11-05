import 'package:flutter/material.dart';

import '../models/fastest_delivery_model.dart';
import 'fastest_delivery_card.dart';

class FastestDeliveryListView extends StatelessWidget {
  const FastestDeliveryListView({super.key});

  final items = const [
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
    FastestDeliveryModel(
      imageUrl:
          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
      title: 'Crazy tacko',
      description: 'Delicouse tackos, appetizing snacks, fr...',
      price: '€3,00',
      rating: '9,5',
    ),
  ];

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
