import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

import '../../models/items_model.dart';

part 'general_popular_items_state.dart';

class GenaralPopularItemsCubit extends Cubit<GenaralPopularItemsState> {
  GenaralPopularItemsCubit() : super(GenaralPopularItemsInitialState());

  Future<void> fetchPopularItems() async {
    emit(GenaralPopularItemsLoadingState());
    log("Fetching popular items...");

    try {
      final items = await FirestoreGetters().getAllPopularItems();

      log("Loaded ${items.length} popular items");

      emit(GenaralPopularItemsLoadedState(items: items));
    } catch (e) {
      if (isClosed) return;
      emit(GenaralPopularItemsFailureState(message: e.toString()));
    }
  }
}
