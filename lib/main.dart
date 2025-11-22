import 'package:delish_app/views/screen/favorite_screen.dart';
import 'package:delish_app/views/screen/restaurants_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const DelishApp());
}

class DelishApp extends StatelessWidget {
  const DelishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FavoriteScreen(),
    );
  }
}
