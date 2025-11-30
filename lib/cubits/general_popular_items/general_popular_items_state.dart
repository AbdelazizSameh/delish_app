part of 'general_popular_items_cubit.dart';

@immutable
sealed class GenaralPopularItemsState {}

final class GenaralPopularItemsInitialState extends GenaralPopularItemsState {}

final class GenaralPopularItemsLoadingState extends GenaralPopularItemsState {}

final class GenaralPopularItemsLoadedState extends GenaralPopularItemsState {
  final List<ItemModel> items;
  GenaralPopularItemsLoadedState({required this.items});
}

final class GenaralPopularItemsFailureState extends GenaralPopularItemsState {
  final String message;
  GenaralPopularItemsFailureState({required this.message});
}
