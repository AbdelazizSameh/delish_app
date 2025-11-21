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
            'https://herway.net/wp-content/uploads/2022/03/serious-man-with-glasses-standing-and-looking-at-distance-1-1024x684.jpg',
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
