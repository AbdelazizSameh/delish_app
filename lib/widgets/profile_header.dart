import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            "https://placehold.co/100x100/F9A825/FFFFFF?text=KA&font=roboto",
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Kareem Alassy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "kareem.alassy@gmail.com",
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
      ],
    );
  }
}
