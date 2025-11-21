import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'carousel_item.dart';
import 'simple_dot_indicator.dart';

class CustomCarouselSliderBuilder extends StatefulWidget {
  const CustomCarouselSliderBuilder({super.key});

  @override
  State<CustomCarouselSliderBuilder> createState() =>
      _CustomCarouselSliderBuilderState();
}

class _CustomCarouselSliderBuilderState
    extends State<CustomCarouselSliderBuilder> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        CarouselSlider.builder(
          itemCount: 4,
          itemBuilder: (context, index, realIndex) => const CarouselItem(),
          options: CarouselOptions(
            viewportFraction: 1,
            autoPlay: true,
            aspectRatio: 2 / 1,
            initialPage: 0,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        SimpleDotIndicator(itemCount: 4, currentIndex: currentIndex),
      ],
    );
  }
}
