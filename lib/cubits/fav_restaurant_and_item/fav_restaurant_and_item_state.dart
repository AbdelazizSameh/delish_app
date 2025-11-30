part of 'fav_restaurant_and_item_cubit.dart';

@immutable
sealed class FavRestaurantAndItemState {}

final class FavRestaurantAndItemInitial extends FavRestaurantAndItemState {}

final class FavRestaurantAndItemLoading extends FavRestaurantAndItemState {}

final class FavRestaurantAndItemLoaded extends FavRestaurantAndItemState {
  final List<String> favoriteRestaurants;
  final List<String> favoriteItems;

  FavRestaurantAndItemLoaded({
    required this.favoriteRestaurants,
    required this.favoriteItems,
  });
}

final class FavRestaurantAndItemError extends FavRestaurantAndItemState {
  final String message;

  FavRestaurantAndItemError(this.message);
}
