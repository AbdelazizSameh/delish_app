import 'package:flutter/material.dart';
import '../models/fastest_delivery_model.dart';
import 'carousel_slider_builder.dart';
import 'custom_discovery_app_bar.dart';
import 'fastest_delivery_list_view.dart';
import 'section_header.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});
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
    return CustomScrollView(
      slivers: [
        const CustomDiscoveryAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        const SliverToBoxAdapter(child: CustomCarouselSliderBuilder()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 19),
            child: Column(
              children: [
                const SectionHeader(title: "Fastest delivery 🔥"),
                FastestDeliveryListView(items: items),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
