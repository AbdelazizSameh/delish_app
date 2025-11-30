import 'package:flutter/material.dart';

class SummaryText extends StatelessWidget {
  final String text;
  final bool isMain;

  const SummaryText(this.text, {super.key, this.isMain = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: isMain ? 18 : 16,
        color: isMain ? Colors.black87 : Colors.black54,
        fontWeight: isMain ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}
