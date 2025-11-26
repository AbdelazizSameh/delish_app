import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Passwordtextfield extends StatefulWidget {
  const Passwordtextfield({super.key, required this.passwordController});
  final TextEditingController passwordController;

  @override
  State<Passwordtextfield> createState() => _PasswordtextfieldState();
}

class _PasswordtextfieldState extends State<Passwordtextfield> {
  bool seen = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      obscureText: !seen,
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              seen = !seen;
            });
          },
          icon: seen
              ? const Icon(Icons.visibility_outlined, color: Colors.deepOrange)
              : const Icon(Icons.visibility_off_outlined, color: Colors.grey),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.grey, width: 1.5),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12).r,
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),

        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(
          color: Colors.deepOrange,
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
      // validation form
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    );
  }
}
