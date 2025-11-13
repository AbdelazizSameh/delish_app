import 'package:delish/Screens/Auth/Home.dart';
import 'package:delish/Screens/Auth/ResetPassword.dart';
import 'package:delish/Screens/Auth/Signup.dart';
import 'package:delish/Services/firebase/SiginGoole.dart';
import 'package:delish/Services/firebase/signinEmailAndPassword.dart';
import 'package:delish/widgets/Auth/PasswordTextField.dart';
import 'package:delish/widgets/Auth/SigninGoogle.dart';
import 'package:delish/widgets/Auth/TextformEmail.dart';
import 'package:delish/widgets/Global/AnyText.dart';
import 'package:delish/widgets/Global/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 50.h),
                    Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 40.h),

                    // Email Field
                    Anytext(
                      content: "Email",
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10.h),

                    Emailtxetform(emailController: emailController),
                    SizedBox(height: 20.h),
                    Anytext(
                      content: "Password",
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(height: 10.h),

                    // password
                    Passwordtextfield(passwordController: passwordController),

                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Resetpassword(),
                            ),
                          );
                        },
                        child: Anytext(
                          content: "Forgot Password",
                          fontWeight: FontWeight.w500,
                          color: Colors.deepOrange,
                          size: 15,
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),
                    CustomButton(
                      text: "Sign in",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          bool success =
                              await SigninEmailAndPassword.signinEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context,
                              );

                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Home()),
                            );
                          }
                        }
                      },
                      color: Colors.deepOrange,
                      borderRadius: 25,
                    ),

                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Anytext(
                          content: "Dont have an account?",
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Signup()),
                            );
                          },
                          child: Anytext(
                            content: "Sign Up",
                            size: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  const Text(
                    "Sig up With",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Expanded(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              //Google
              GoogleSignInButton(
                onPressed: () async {
                  User? user = await GoogleSignInService.signInWithGoogle();
                  if (user != null) {                    
                  } else {
                    // فشل تسجيل الدخول
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Google Sign-In failed")),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
