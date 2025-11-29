import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

part 'specific_items_for_restaurants_state.dart';

class SpecificItemsForRestaurantsCubit
    extends Cubit<SpecificItemsForRestaurantsState> {
  SpecificItemsForRestaurantsCubit() : super(SpecificItemsInitial());

  Future<void> fetchSpecificItems(String restaurantId) async {
    if (isClosed) return;
    emit(SpecificItemsLoading());
    log("Fetching restaurant items for: $restaurantId");

    try {
      final items = await FirestoreGetters().getRestaurantItems(restaurantId);

      log("Total items fetched: ${items}");

      emit(SpecificItemsLoaded());
    } catch (e) {
      log("Error fetching items: $e");
      if (!isClosed) emit(SpecificItemsFailure(message: e.toString()));
    }
  }
}
