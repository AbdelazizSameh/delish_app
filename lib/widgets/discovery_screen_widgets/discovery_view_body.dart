import 'package:flutter/material.dart';
import 'carousel_slider_builder.dart';
import 'custom_app_bar.dart';
import 'fastest_delivery_list_view.dart';
import 'popular_items_list_view.dart';
import '../shared/section_header.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: const [
        CustomAppBar(),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverToBoxAdapter(child: CustomCarouselSliderBuilder()),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 19),
            child: Column(
              children: [
                SectionHeader(title: "Fastest  🔥"),
                FastestDeliveryListView(),
                SectionHeader(title: "Popular items 👏"),
                PopularItemsListView(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
