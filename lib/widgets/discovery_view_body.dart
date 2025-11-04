import 'package:flutter/material.dart';

import 'custom_discovery_app_bar.dart';

class DiscoveryViewBody extends StatelessWidget {
  const DiscoveryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [const CustomDiscoveryAppBar(),]);
  }
}
