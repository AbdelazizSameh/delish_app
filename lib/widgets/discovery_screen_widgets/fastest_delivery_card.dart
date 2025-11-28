import 'dart:developer';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:delish/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/fastest_delivery_model.dart';

class FastestDeliveryCard extends StatelessWidget {
  final FastestDeliveryModel deliveryItem;

  const FastestDeliveryCard({super.key, required this.deliveryItem});

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
    return Container(
      width: 290,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: CachedNetworkImage(
              imageUrl: deliveryItem.imageUrl,
              height: 130,
              width: double.infinity,
              fit: BoxFit.contain,
              placeholder: (context, url) => Container(
                height: 130,
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
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  deliveryItem.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  restaurantDescriptions[rand.nextInt(
                    restaurantDescriptions.length,
                  )],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF727272),
                  ),
                ),
                const SizedBox(height: 6),
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
                      deliveryItem.rating.toString(),
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
    );
  }
}
