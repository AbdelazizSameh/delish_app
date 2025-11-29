import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/models/restaurants_model.dart';
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
              List<String> favIds = snapshot.docs
                  .map(
                    (doc) =>
                        (doc.data() as Map<String, dynamic>)['id'] as String,
                  )
                  .toList();

              _fetchRestaurantsByIds(favIds);
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

  Future<void> _fetchRestaurantsByIds(List<String> favIds) async {
    try {
      final restaurants = await Future.wait(
        favIds.map((id) async {
          final doc = await FirestoreGetters().getRestaurantById(id);
          if (doc == null) return null; 
          return RestaurantModel.fromMap(doc, id);
        }),
      );

      final res = restaurants.whereType<RestaurantModel>().toList();

      log(res.toString());
      emit(GetFavouriteRestaurantsLoaded(restaurants: res));
    } catch (e) {
      log("Error fetching favourite restaurants: $e");
      emit(GetFavouriteRestaurantsFailure(message: e.toString()));
    }
  }
}
