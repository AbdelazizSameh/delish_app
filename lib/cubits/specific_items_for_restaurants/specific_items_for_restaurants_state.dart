part of 'specific_items_for_restaurants_cubit.dart';

@immutable
sealed class SpecificItemsForRestaurantsState {}

final class SpecificItemsInitial extends SpecificItemsForRestaurantsState {}

final class SpecificItemsLoading extends SpecificItemsForRestaurantsState {}

final class SpecificItemsLoaded extends SpecificItemsForRestaurantsState {
  SpecificItemsLoaded();
}

final class SpecificItemsFailure extends SpecificItemsForRestaurantsState {
  final String message;
  SpecificItemsFailure({required this.message});
}
