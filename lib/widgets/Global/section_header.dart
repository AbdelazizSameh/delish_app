import 'package:flutter/material.dart';

import '../../Services/firebase/Addfunctions/Addfunctions.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final bool? seeAll;
  const SectionHeader({super.key, required this.title, this.seeAll = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          if (seeAll == true)
            TextButton(
              onPressed: () async {
                // await FirestoreService().addFavoriteRestaurant(
                //   userId: 't4nMAvE6NuOI0KvsqIc36yvSmGX2',
                //   restaurantId: '1if9Yn74ix3RkGOEfEFL',
                //   restaurantName: 'Pizza King',
                // );

                // await FirestoreService().addFavoriteItem(
                //   userId: 't4nMAvE6NuOI0KvsqIc36yvSmGX2',
                //   itemId: 'Cja0XIq6RqqBTzUQliUB',
                //   itemName: 'رانش تشيكن بيكون ايطالى (وسط)',
                //   restaurantId: '1if9Yn74ix3RkGOEfEFL',
                // );
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xffFED8CC),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              child: Text(
                'See all',
                style: TextStyle(
                  color: const Color(0xffF83B01),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
