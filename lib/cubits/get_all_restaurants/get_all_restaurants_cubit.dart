import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

part 'get_all_restaurants_state.dart';

class GetAllRestaurantsCubit extends Cubit<GetAllRestaurantsState> {
  GetAllRestaurantsCubit() : super(GetAllRestaurantsInitialState());

  StreamSubscription? _subscription;

  void fetchAllRestaurants() {
    emit(GetAllRestaurantsLoadingState());
    log("Fetching all restaurants…");

    try {
      _subscription = FirestoreGetters().getAllRestaurants().listen(
        (snapshot) {
          final restaurants = snapshot.docs
              .map((doc) => doc.data() as Map<String, dynamic>)
              .toList();

          log("loaded ${restaurants.length} from all restaurant");
          emit(GetAllRestaurantsLoadedState());
        },
        onError: (e) {
          log("Error: $e");
          emit(GetAllRestaurantsFailureState(message: e.toString()));
        },
      );
    } catch (e) {
      emit(GetAllRestaurantsFailureState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
