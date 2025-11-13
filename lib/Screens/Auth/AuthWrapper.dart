import 'package:delish/Screens/Auth/Home.dart';
import 'package:delish/Screens/Auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        // لسه بيتحقق من حالة اليوزر
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // لو مفيش يوزر → يروح Login
        if (!snapshot.hasData) {
          return Login(); 
        }

        // لو فيه يوزر → يروح Home
        return Home();
      },
    );
  }
}
