import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

part 'get_favourite_items_state.dart';

class GetFavouriteItemsCubit extends Cubit<GetFavouriteItemsState> {
  GetFavouriteItemsCubit() : super(GetFavouriteItemsInitial());

  StreamSubscription? _subscription;

  void fetchFavouriteItems(String userId) {
    emit(GetFavouriteItemsLoading());
    log("Fetching favourite items for user: $userId");

    try {
      _subscription = FirestoreGetters()
          .getFavoriteItems(userId)
          .listen(
            (snapshot) {
              List<Map<String, dynamic>> items = snapshot.docs
                  .map((doc) => doc.data() as Map<String, dynamic>)
                  .toList();

              log("Total favourite items: ${items.length}");

              // for (var item in items) {
              //   log("Item ID: ${item['item_id']}");
              // }

              emit(GetFavouriteItemsLoaded(items: items));
            },
            onError: (e) {
              log("Stream error: $e");
              emit(GetFavouriteItemsFailure(message: e.toString()));
            },
          );
    } catch (e) {
      log("Error: $e");
      emit(GetFavouriteItemsFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    log("Cancelling favourite items subscription");
    _subscription?.cancel();
    return super.close();
  }
}
