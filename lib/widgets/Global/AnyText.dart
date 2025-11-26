import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Anytext extends StatelessWidget {
  const Anytext({super.key, required this.content, required this.size, required this.fontWeight, required this.color});
  final String content;
  final int size;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(fontSize: size.sp, fontWeight: fontWeight, color: color),
    );
  }
}
