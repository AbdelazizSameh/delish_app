import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterEmailAndPassword {
  static Future<bool> registerEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // بعد ما المستخدم اتعمل
      final userId = credential.user!.uid;

      // إضافة بيانات المستخدم الأساسية في Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'email': email,
        'phone': '',
        'address': '',
      });

      // إنشاء document أولي في favorites_restaurants
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites_restaurants')
          .doc('initial')
          .set({'saved_at': FieldValue.serverTimestamp()});

      // إنشاء document أولي في favorites_items
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('favorites_items')
          .doc('initial')
          .set({'saved_at': FieldValue.serverTimestamp()});

      // إنشاء document أولي في orders
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc('initial')
          .set({
        'restaurantId': '',
        'totalPrice': 0,
        'status': 'init',
        'createdAt': FieldValue.serverTimestamp(),
        'items': [],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signed up successfully'),
          backgroundColor: Colors.green,
        ),
      );
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'weak-password') {
        errorMessage = 'Password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'Invalid email format.';
      } else {
        errorMessage = 'Error: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      return false;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Unexpected error: $e'),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }
}
