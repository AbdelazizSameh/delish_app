import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:delish/utils/general_functions.dart';
import 'package:meta/meta.dart';

import '../../models/restaurants_categories_model.dart';

part 'get_categories_with_count_state.dart';

class GetCategoriesWithCountCubit extends Cubit<GetCategoriesWithCountState> {
  GetCategoriesWithCountCubit() : super(GetCategoriesWithCountInitialState());

  StreamSubscription? _subscription;
  Future<void> fetchCategoriesWithCount() async {
    if (isClosed) return;
    emit(GetCategoriesWithCountLoadingState());
    log("Fetching categories with items count…");

    try {
      final results = await Future.wait(
        restaurantsIDs.map((restaurantId) async {
          final categories = await FirestoreGetters()
              .getCategoriesWithCount(restaurantId)
              .first;
          return categories
              .map((e) => RestaurantsCategoriesModel.fromJson(e))
              .toList();
        }),
      );

      final allCategories = results.expand((list) => list).toList();

      emit(GetCategoriesWithCountLoadedState(categories: allCategories));
      log("All categories loaded successfully.");
    } catch (e) {
      if (isClosed) return;
      emit(GetCategoriesWithCountFailureState(message: e.toString()));
      log("Error fetching categories: $e");
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
