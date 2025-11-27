import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

part 'get_categories_with_count_state.dart';

class GetCategoriesWithCountCubit extends Cubit<GetCategoriesWithCountState> {
  GetCategoriesWithCountCubit() : super(GetCategoriesWithCountInitialState());

  StreamSubscription? _subscription;

  void fetchCategoriesWithCount(String restaurantId) {
    emit(GetCategoriesWithCountLoadingState());
    log("Fetching categories with items count…");

    try {
      _subscription = FirestoreGetters()
          .getCategoriesWithCount(restaurantId)
          .listen(
            (categories) {
              for (var cat in categories) {
                log("• Category: ${cat['name']} | Items: ${cat['itemCount']}");
              }
              emit(GetCategoriesWithCountLoadedState());
            },
            onError: (e) {
              log("Error: $e");
              emit(GetCategoriesWithCountFailureState(message: e.toString()));
            },
          );
    } catch (e) {
      emit(GetCategoriesWithCountFailureState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
