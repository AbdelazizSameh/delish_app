part of 'get_favourite_items_cubit.dart';

@immutable
sealed class GetFavouriteItemsState {}

final class GetFavouriteItemsInitial extends GetFavouriteItemsState {}

final class GetFavouriteItemsLoading extends GetFavouriteItemsState {}

final class GetFavouriteItemsLoaded extends GetFavouriteItemsState {
  final List<Map<String, dynamic>> items;
  GetFavouriteItemsLoaded({required this.items});
}

final class GetFavouriteItemsFailure extends GetFavouriteItemsState {
  final String message;
  GetFavouriteItemsFailure({required this.message});
}
