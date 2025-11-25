import 'package:delish_app/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xffF96234),
            child: SvgPicture.asset(AppAssets.home, width: 19, height: 19),
          ),
          SizedBox(width: 10),
          Text(
            'Home, ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          Text('Jl. Soekarno Hatta 15A', style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
