import 'package:delish/screens/Auth/login.dart';
import 'package:delish/screens/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        
        // Still loading authentication state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // NOT logged in → Go to Login
        if (!snapshot.hasData) {
          return const Login();
        }

        // Logged in → Go to Home
        return const HomeView();
      },
    );
  }
}
