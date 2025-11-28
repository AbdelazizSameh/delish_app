import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

import '../../models/fastest_delivery_model.dart';

part 'fastest_restaurants_state.dart';

class FastestRestaurantsCubit extends Cubit<FastestRestaurantsState> {
  FastestRestaurantsCubit() : super(FastestRestaurantsInitialState());

  StreamSubscription? _subscription;

  void fetchFastRestaurants() {
    emit(FastestRestaurantsLoadingState());
    log("Fetching fast restaurants...");

    try {
      _subscription = FirestoreGetters().getFastRestaurants().listen(
        (snapshot) {
          final restaurants = snapshot.docs
              .map(
                (doc) => FastestDeliveryModel.fromJson(
                  doc.data() as Map<String, dynamic>,
                ),
              )
              .toList();

          emit(FastestRestaurantsLoadedState(restaurants: restaurants));
        },
        onError: (e) {
          log("Error: $e");
          emit(FastestRestaurantsFaluireState(message: e.toString()));
        },
      );
    } catch (e) {
      emit(FastestRestaurantsFaluireState(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
