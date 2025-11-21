import 'dart:ui';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  double _titleOpacity = 0;
  double _buttonsOpacity = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _titleOpacity = 1);
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _buttonsOpacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient + subtle blur overlay
            Positioned.fill(
            child: Stack(
            children: [
          // Blur layer (خفيف)
                BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(color: Colors.transparent),
              ),

          // Gradient overlay
               Container(
              decoration: const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
              Color(0x00FFFFFF),  
              Color(0x33FFFFFF),
              Color(0x66FFFFFF),
              Color(0xFFFFE0B2),
              Color(0xFFFFA64D),    
              Color(0xFFF64F1D),  
            ],
            stops: [0.0, 0.1, 0.2, 0.45 , 0.7 ,1.0],
          ),
        ),
      ),
    ],
  ),
),
          // Main content
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),

                  // Title and subtitle
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _titleOpacity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                             fontFamily: 'Poppins',
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Delish',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color:Color(0xFFFF4400),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 800),
                    opacity: _titleOpacity,
                    child: Text(
                      'Get your favorite meals delivered quickly\nright to your doorstep',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                        height: 1.4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 42),

                  // Start with Email button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                       // Navigator.pushNamed(context, '/sign up');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 80),
                      ),
                      child: const Text(
                        'Start with Email',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  const Spacer(flex: 4),

                  // Continue with Google & Sign in
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          //Navigator.pushNamed(context, '/login');
                        },
                        icon: Image.asset(
                          'assets/images/google_icon.png',
                          width: 22,
                          height: 22,
                        ),
                        label: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 14),
                          child: Text(
                            'Continue with Google',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 2,
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.grey[800],
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // placeholder Sign in
                              // Navigator.pushNamed(context, '/signin');
                            },
                            child: const Text(
                              'Sign in',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,     
                                decorationColor: Colors.white, 
                                decorationThickness: 2,         
                                decorationStyle: TextDecorationStyle.solid, 
                               letterSpacing: 0.3,
                               height: 2.0,          
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // Temporary arrow to go to SearchPage
          Positioned(
            top: 40,
            left: 20,
            child:  IconButton(
              onPressed: (){
             Navigator.pushNamed(context, '/search');
              },
               icon:const Icon (
              Icons.arrow_forward_ios_rounded,
              color: Color.fromARGB(255, 11, 0, 0),
             size: 28,  
               ),
                ),
          ),
        ],
      ),
    );
  }
}