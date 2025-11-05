import 'package:flutter/material.dart';
import '../utils/profile_items_list.dart';
import 'custom_logout_button.dart';
import 'profile_header.dart';
import 'profile_item.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [const ProfileHeader(), const SizedBox(height: 16)],
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          sliver: SliverList.builder(
            itemCount: profileItemsData.length,
            itemBuilder: (context, index) {
              final item = profileItemsData[index];
              return ProfileItem(
                iconAsset: item.iconAsset,
                text: item.text,
                onTap: item.onTap,
              );
            },
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 20)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(width: 150, child: const CustomLogoutButton()),
            ),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 20)),
      ],
    );
  }
}
