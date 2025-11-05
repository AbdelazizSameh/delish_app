import 'package:flutter/material.dart';
import 'carousel_slider_builder.dart';
import 'custom_discovery_app_bar.dart';
import 'fastest_delivery_card.dart';
import 'section_header.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});

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
                SizedBox(
                  height: 244,
                  child: ListView.builder(
                    itemCount: 12,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => FastestDeliveryCard(
                      imageUrl:
                          'https://media.greenchef.com/w_3840,q_auto,f_auto,c_limit,fl_lossy/hellofresh_website/gn/cms/GC_Y23_R5015_W19_UK_GCLC35913740-3_Main_low.jpg',
                      title: 'Crazy tacko',
                      description: 'Delicouse tackos, appetizing snacks, fr...',
                      price: '€3,00',
                      rating: '9,5',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
