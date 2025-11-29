import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/fastest_restaurants/fastest_restaurants_cubit.dart';
import 'fastest_delivery_card.dart';

class FastestDeliveryListView extends StatelessWidget {
  const FastestDeliveryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FastestRestaurantsCubit, FastestRestaurantsState>(
      builder: (context, state) {
        if (state is FastestRestaurantsLoadedState) {
          return SizedBox(
            height: 250,
            child: ListView.builder(
              itemCount: state.restaurants.length,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) =>
                  FastestDeliveryCard(deliveryItem: state.restaurants[index]),
            ),
          );
        } else if (state is FastestRestaurantsLoadingState) {
          return const SizedBox(
            height: 250,
            child: Center(child: CupertinoActivityIndicator()),
          );
        } else {
          return const SizedBox(
            height: 250,
            child: Center(child: Text("Failed to Load data")),
          );
        }
      },
    );
  }
}
