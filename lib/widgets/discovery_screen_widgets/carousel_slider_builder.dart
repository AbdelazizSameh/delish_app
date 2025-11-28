import 'package:carousel_slider/carousel_slider.dart';
import 'package:delish/cubits/carousel_index/carousel_index_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'carousel_item.dart';
import 'simple_dot_indicator.dart';

class CustomCarouselSliderBuilder extends StatelessWidget {
  const CustomCarouselSliderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CarouselIndexCubit(),
      child: Column(
        spacing: 15,
        children: [
          Builder(
            builder: (context) {
              final cubit = BlocProvider.of<CarouselIndexCubit>(context);
              return CarouselSlider.builder(
                itemCount: cubit.carouselItems,
                itemBuilder: (_, index, __) => const CarouselItem(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  aspectRatio: 2 / 1,
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    cubit.changeIndex(index);
                  },
                ),
              );
            },
          ),

          BlocSelector<CarouselIndexCubit, int, int>(
            selector: (state) => state,
            builder: (context, currentIndex) {
              final cubit = BlocProvider.of<CarouselIndexCubit>(context);
              return SimpleDotIndicator(
                itemCount: cubit.carouselItems,
                currentIndex: currentIndex,
              );
            },
          ),
        ],
      ),
    );
  }
}
