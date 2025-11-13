import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  static Future<User?> signInWithGoogle() async {
    try {
      // امسح أي تسجيل دخول قديم
      await googleSignIn.signOut();

      // تسجيل دخول جديد
      final googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        log("User canceled login");
        return null;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      log("Google user logged in: ${userCredential.user!.email}");
      return userCredential.user;
    } catch (e) {
      log("Google Sign-In Error: $e");
      return null;
    }
  }

 static Future<void> signOut() async {
  try {
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();   
    log("Google + Firebase signed out");
  } catch (e) {
    log("Google Sign-Out Error: $e");
  }
}


}
