// auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class RegisterEmailAndPassword {
  // ====================== تسجيل بسيط ونظيف (بدون placeholders) ======================
  static Future<bool> registerEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      // 1. تسجيل في Firebase Auth
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final userId = credential.user!.uid;

      // 2. إنشاء وثيقة المستخدم فقط
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': name,
        'email': email.trim(),
        'phone': '',
        'address': '',
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. رسالة نجاح
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم التسجيل بنجاح!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }

      developer.log('تم إنشاء المستخدم: $userId');
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'weak-password':
          errorMessage = 'كلمة المرور ضعيفة جدًا (6 أحرف على الأقل).';
          break;
        case 'email-already-in-use':
          errorMessage = 'البريد الإلكتروني مستخدم من قبل.';
          break;
        case 'invalid-email':
          errorMessage = 'صيغة البريد الإلكتروني غير صحيحة.';
          break;
        case 'operation-not-allowed':
          errorMessage = 'التسجيل معطل مؤقتًا.';
          break;
        default:
          errorMessage = 'فشل التسجيل: ${e.message}';
      }

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
          ),
        );
      }
      return false;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ غير متوقع: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return false;
    }
  }
}