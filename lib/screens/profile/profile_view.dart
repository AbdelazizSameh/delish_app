import 'package:flutter/material.dart';
import '../../widgets/profile_screen_widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ProfileViewBody()));
  }
}
