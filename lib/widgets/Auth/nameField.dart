import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Namefield extends StatefulWidget {
  const Namefield({super.key});

  @override
  State<Namefield> createState() => _TextformemailState();
}

class _TextformemailState extends State<Namefield> {
  final TextEditingController namelController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: namelController,
      decoration: InputDecoration(
        labelText: "Name ",
        hintText: "Enter your Name",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.grey, width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.bold,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.grey, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
      ),
      //validation form
       validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Name';
        }
        return null;
      },
    );
  }
}
