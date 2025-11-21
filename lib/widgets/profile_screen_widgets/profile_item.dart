import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
    required this.iconAsset,
    required this.text,
    required this.onTap,
  });

  final String iconAsset;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      leading: SvgPicture.asset(
        iconAsset,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(Color(0xffFE8800), BlendMode.srcIn),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
  }
}
