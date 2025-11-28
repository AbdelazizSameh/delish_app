part of 'fastest_restaurants_cubit.dart';

@immutable
sealed class FastestRestaurantsState {}

final class FastestRestaurantsInitialState extends FastestRestaurantsState {}

final class FastestRestaurantsLoadedState extends FastestRestaurantsState {
  final List<FastestDeliveryModel> restaurants;

  FastestRestaurantsLoadedState({required this.restaurants});
}

final class FastestRestaurantsLoadingState extends FastestRestaurantsState {}

final class FastestRestaurantsFaluireState extends FastestRestaurantsState {
  final String message;

  FastestRestaurantsFaluireState({required this.message});
}
