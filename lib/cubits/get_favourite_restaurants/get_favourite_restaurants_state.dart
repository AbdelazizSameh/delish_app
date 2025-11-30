part of 'get_favourite_restaurants_cubit.dart';

@immutable
sealed class GetFavouriteRestaurantsState {}

final class GetFavouriteRestaurantsInitial
    extends GetFavouriteRestaurantsState {}

final class GetFavouriteRestaurantsLoading
    extends GetFavouriteRestaurantsState {}

final class GetFavouriteRestaurantsLoaded extends GetFavouriteRestaurantsState {
  final List<RestaurantModel> restaurants;
  GetFavouriteRestaurantsLoaded({required this.restaurants});
}

final class GetFavouriteRestaurantsFailure
    extends GetFavouriteRestaurantsState {
  final String message;
  GetFavouriteRestaurantsFailure({required this.message});
}
