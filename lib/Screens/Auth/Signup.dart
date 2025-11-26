import 'package:delish/Screens/Auth/Login.dart';
import 'package:delish/Services/firebase/RegisterEmailAndPassword.dart';
import 'package:delish/Services/firebase/SiginGoole.dart';
import 'package:delish/widgets/Auth/NameField.dart';
import 'package:delish/widgets/Auth/PasswordTextField.dart';
import 'package:delish/widgets/Auth/SigninGoogle.dart';
import 'package:delish/widgets/Auth/TextformEmail.dart';
import 'package:delish/widgets/Global/AnyText.dart';
import 'package:delish/widgets/Global/CustomButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Text(""),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sigin up",
                      style: TextStyle(
                        fontFamily: "Rubik",
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Anytext(
                      content: "Name",
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 44, 44, 44),
                    ),
                    SizedBox(height: 10.h),

                    Namefield(namelController: nameController,),
                    SizedBox(height: 20.h),
                    // Email Field
                    Anytext(
                      content: "Email",
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 44, 44, 44),
                    ),
                    SizedBox(height: 10.h),

                    Emailtxetform(emailController: emailController),
                    SizedBox(height: 25.h),
                    // password
                    Anytext(
                      content: "Password",
                      size: 15,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 44, 44, 44),
                    ),
                    SizedBox(height: 10.h),
                    Passwordtextfield(passwordController: passwordController),

                    SizedBox(height: 35.h),

                    CustomButton(
                      text: "Sign up",
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          bool success =
                              await RegisterEmailAndPassword.registerEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                context: context,
                                name: nameController.text,
                              );

                          // لو التسجيل نجح، ننتقل
                          if (success) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
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
                          content: " Have already an account?",
                          size: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          child: Anytext(
                            content: "Sign in",
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
              SizedBox(height: 10.h),
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
              Center(
                child: GoogleSignInButton(
                  onPressed: () async {
                    User? user = await GoogleSignInService.signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Google Sign-In failed")),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
