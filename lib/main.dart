import 'package:delish_app/screens/home/home_view.dart';
import 'package:flutter/material.dart';
import 'views/screen/food_details.dart';
import 'views/screen/search_page.dart';
import 'views/screen/welcome_page.dart';
import 'views/screen/widgets/food_item.dart';

Future<void> main() async {
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

      home: const HomeView(),
    );
  }
}
