import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'carousel_slider_builder.dart';
import '../Global/custom_sliver_app_bar.dart';
import 'fastest_delivery_list_view.dart';
import 'popular_items_list_view.dart';
import '../Global/section_header.dart';
import 'popular_items_list_view_provider.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: const [
        CustomSliverAppBar(),
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
                PopularItemsListViewProvider(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 100)),
      ],
    );
  }
}
