import 'package:delish/widgets/Auth/TextformEmail.dart';
import 'package:delish/widgets/Global/AnyText.dart';
import 'package:delish/widgets/Global/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Resetpassword extends StatefulWidget {
  const Resetpassword({super.key});

  @override
  State<Resetpassword> createState() => _ResetpasswordState();
}

class _ResetpasswordState extends State<Resetpassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Anytext(
                content: "Reset Password",
                size: 30,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              SizedBox(height: 20.h),
              Anytext(
                content:
                    "Please Enter your email address to reset your password",
                size: 15,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              SizedBox(height: 20.h),
              Anytext(
                content: "Email",
                size: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              SizedBox(height: 20.h),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Emailtxetform(emailController: emailController),
                    SizedBox(height: 50.h),
                    CustomButton(
                      text: "Continue",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance.sendPasswordResetEmail(
                              email: emailController.text.trim(),
                            );

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "✅ Reset link sent! Check your inbox.",
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            Navigator.pop(context); // العودة لصفحة Login
                          } on FirebaseAuthException catch (e) {
                            String errorMessage = '';
                            if (e.code == 'user-not-found') {
                              errorMessage = 'No user found with this email.';
                            } else if (e.code == 'invalid-email') {
                              errorMessage = 'Invalid email format.';
                            } else {
                              errorMessage = 'Error: ${e.message}';
                            }

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Unexpected error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
