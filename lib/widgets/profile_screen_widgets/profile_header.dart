import 'package:cached_network_image/cached_network_image.dart';
import 'package:delish/utils/general_functions.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          width: 110,
          height: 110,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  'https://www.pngkey.com/png/detail/349-3499617_person-placeholder-person-placeholder.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          userModel?.name ?? '',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          userModel?.email ?? '',
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }
}
