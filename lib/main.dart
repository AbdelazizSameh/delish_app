import 'package:flutter/material.dart';

import 'screens/discovery/discovery_view.dart';

void main() {
  runApp(const DelishApp());
}

class DelishApp extends StatelessWidget {
  const DelishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Rubik-Regular",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarThemeData(backgroundColor: Colors.white),
      ),

      home: const DiscoveryView(),
    );
  }
}
