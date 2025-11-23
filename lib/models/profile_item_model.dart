import 'package:flutter/material.dart';

class ProfileItemModel {
  final String iconAsset;
  final String text;
  final VoidCallback onTap;

  const ProfileItemModel({
    required this.iconAsset,
    required this.text,
    required this.onTap,
  });
}
