import 'package:flutter/material.dart';

class DiscoveryView extends StatelessWidget {
  const DiscoveryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("this is first widget", style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}
