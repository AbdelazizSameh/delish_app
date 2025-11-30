import 'package:flutter/material.dart';

class AppMessenger {

  static void show(
    BuildContext context, {
    required String message,
    Color? background,
    IconData? icon,
    int duration = 2,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: background ?? Colors.black87,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              Icon(icon ?? Icons.info, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    show(
      context,
      message: message,
      background: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void error(BuildContext context, String message) {
    show(context, message: message, background: Colors.red, icon: Icons.error);
  }

  static void warning(BuildContext context, String message) {
    show(
      context,
      message: message,
      background: Colors.orange,
      icon: Icons.warning,
    );
  }

  static void info(BuildContext context, String message) {
    show(
      context,
      message: message,
      background: Colors.blue,
      icon: Icons.info_outline,
    );
  }
}
