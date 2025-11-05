
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_assets.dart';

class CustomLogoutButton extends StatelessWidget {
  const CustomLogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Color(0xffF83B01);

    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        side: const BorderSide(color: Color(0xffF83B01), width: 1.2),
      ),
      label: const Text(
        "Log out",
        style: TextStyle(
          color: Color(0xffFE8800),
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      icon: SvgPicture.asset(
        AppAssets.profileLogout,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(color, BlendMode.srcIn),
      ),
    );
  }
}
