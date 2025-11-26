import 'package:delish/Services/firebase/SiginGoole.dart'
    show GoogleSignInService;
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()async {
           await GoogleSignInService.signOut();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      // body: ,
    );
  }
}
