import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/restaurants_model.dart';
import '../../utils/app_assets.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurantModel;
  final VoidCallback? onTap;

  const RestaurantCard({super.key, this.onTap, required this.restaurantModel});

  @override
  Widget build(BuildContext context) {
    final Random rand = Random();
    final List<String> restaurantDescriptions = [
      "A highly trusted restaurant known for excellent service, consistent quality, and a welcoming atmosphere for all customers.",
      "A top-rated dining spot recognized for its professionalism, hygiene, and commitment to delivering an exceptional experience.",
      "A well-established restaurant with a strong reputation in the community and a focus on customer satisfaction.",
      "A popular destination admired for its friendly staff, organized service, and smooth dining experience.",
      "A customer-focused restaurant that values hospitality, efficiency, and maintaining high service standards.",
      "A modern and reliable restaurant offering quality service and a comfortable environment for all guests.",
      "A highly reviewed place known for its clean environment, fast service, and professional team.",
      "A trusted local favorite recognized for attention to detail, consistency, and excellent customer care.",
      "A welcoming restaurant offering great service, efficient operations, and a relaxing dining atmosphere.",
      "A respected establishment with strong service standards and a dedication to making every visit enjoyable.",
    ];
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: restaurantModel.image,
                height: 170,
                width: double.infinity,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  height: 170,
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  height: 130,
                  color: Colors.grey[200],
                  child: const Icon(
                    Icons.broken_image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurantModel.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    restaurantDescriptions[rand.nextInt(
                      restaurantDescriptions.length,
                    )],
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.wallet, height: 14),
                      const SizedBox(width: 4),
                      Text(
                        (rand.nextDouble() * 10 + 10).toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(AppAssets.star, height: 14),
                      const SizedBox(width: 4),
                      Text(
                        restaurantModel.rating.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
