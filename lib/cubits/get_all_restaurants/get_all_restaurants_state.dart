part of 'get_all_restaurants_cubit.dart';

@immutable
sealed class GetAllRestaurantsState {}

final class GetAllRestaurantsInitialState extends GetAllRestaurantsState {}

final class GetAllRestaurantsLoadingState extends GetAllRestaurantsState {}

final class GetAllRestaurantsLoadedState extends GetAllRestaurantsState {
  GetAllRestaurantsLoadedState();
}

final class GetAllRestaurantsFailureState extends GetAllRestaurantsState {
  final String message;
  GetAllRestaurantsFailureState({required this.message});
}
