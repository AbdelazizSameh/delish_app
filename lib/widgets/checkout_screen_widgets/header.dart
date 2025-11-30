import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final VoidCallback onChange;

  const Header({super.key, required this.title, required this.onChange});

  @override
  Widget build(BuildContext context) {
    const changeStyle = TextStyle(
      color: Color(0xFFFF7043),
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: onChange,
          child: const Text('Change', style: changeStyle),
        ),
      ],
    );
  }
}
