import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../Services/firebase/GetFunctions/getfunctions.dart';

part 'get_favourite_restaurants_state.dart';

class GetFavouriteRestaurantsCubit extends Cubit<GetFavouriteRestaurantsState> {
  GetFavouriteRestaurantsCubit() : super(GetFavouriteRestaurantsInitial());

  StreamSubscription? _subscription;

  void fetchFavouriteRestaurants(String userId) {
    emit(GetFavouriteRestaurantsLoading());
    log("Fetching favourite restaurants for user: $userId");

    try {
      _subscription = FirestoreGetters()
          .getFavoriteRestaurants(userId)
          .listen(
            (snapshot) {
              List<Map<String, dynamic>> favs = snapshot.docs
                  .map((doc) => doc.data() as Map<String, dynamic>)
                  .toList();

              log("Total favourite Restaurant : $favs");

              // for (var fav in favs) {
              //   log("Restaurant ID: ${fav['restaurant_id']}");
              // }

              emit(GetFavouriteRestaurantsLoaded(restaurants: favs));
            },
            onError: (e) {
              log("Stream error: $e");
              emit(GetFavouriteRestaurantsFailure(message: e.toString()));
            },
          );
    } catch (e) {
      log("Error: $e");
      emit(GetFavouriteRestaurantsFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    log("Cancelling favourite restaurants subscription");
    _subscription?.cancel();
    return super.close();
  }
}
