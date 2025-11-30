part of 'get_categories_with_count_cubit.dart';

@immutable
abstract class GetCategoriesWithCountState {}

class GetCategoriesWithCountInitialState extends GetCategoriesWithCountState {}

class GetCategoriesWithCountLoadingState extends GetCategoriesWithCountState {}

class GetCategoriesWithCountLoadedState extends GetCategoriesWithCountState {
  final List<RestaurantsCategoriesModel> categories;

  GetCategoriesWithCountLoadedState({required this.categories});
}

class GetCategoriesWithCountFailureState extends GetCategoriesWithCountState {
  final String message;

  GetCategoriesWithCountFailureState({required this.message});
}
