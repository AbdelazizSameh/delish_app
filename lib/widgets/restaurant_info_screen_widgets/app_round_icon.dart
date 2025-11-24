import 'dart:ui';
import 'package:flutter/material.dart';

class AppRoundIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const AppRoundIcon({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xff847971).withValues(alpha: 0.9),
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
