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
      title: 'Delish', // App title
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(primarySwatch: Colors.orange), // App theme color
      initialRoute: '/', // Initial route when app starts
      routes: {
        '/': (_) => const WelcomePage(), // Welcome page route
        '/search': (_) => const SearchPage(), // Search page route
        // FoodDetails screen usually requires arguments,
        // so it should be navigated with Navigator.push and MaterialPageRoute
      },
    );
  }
}