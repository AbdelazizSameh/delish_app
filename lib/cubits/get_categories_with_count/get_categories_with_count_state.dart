part of 'get_categories_with_count_cubit.dart';

@immutable
sealed class GetCategoriesWithCountState {}

final class GetCategoriesWithCountInitialState
    extends GetCategoriesWithCountState {}

final class GetCategoriesWithCountLoadingState
    extends GetCategoriesWithCountState {}

final class GetCategoriesWithCountLoadedState
    extends GetCategoriesWithCountState {
  GetCategoriesWithCountLoadedState();
}

final class GetCategoriesWithCountFailureState
    extends GetCategoriesWithCountState {
  final String message;
  GetCategoriesWithCountFailureState({required this.message});
}
