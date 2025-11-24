import 'package:flutter/material.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://images.pexels.com/photos/1128678/pexels-photo-1128678.jpeg",
      height: 280,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
