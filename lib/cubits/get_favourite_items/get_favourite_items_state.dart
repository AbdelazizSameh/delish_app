part of 'get_favourite_items_cubit.dart';

@immutable
sealed class GetFavouriteItemsState {}

final class GetFavouriteItemsInitial extends GetFavouriteItemsState {}

final class GetFavouriteItemsLoading extends GetFavouriteItemsState {}

final class GetFavouriteItemsLoaded extends GetFavouriteItemsState {
  GetFavouriteItemsLoaded();
}

final class GetFavouriteItemsFailure extends GetFavouriteItemsState {
  final String message;
  GetFavouriteItemsFailure({required this.message});
}
