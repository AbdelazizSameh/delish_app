import 'package:flutter/material.dart';
import 'carousel_slider_builder.dart';
import 'custom_discovery_app_bar.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CustomDiscoveryAppBar(),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        const SliverToBoxAdapter(child: CustomCarouselSliderBuilder()),
      ],
    );
  }
}
