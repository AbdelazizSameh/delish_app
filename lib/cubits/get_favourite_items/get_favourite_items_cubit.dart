import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delish/Services/firebase/GetFunctions/getfunctions.dart';
import 'package:meta/meta.dart';

import '../../models/items_model.dart';

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
            (snapshot) async {
              List<ItemModel> items = [];

              for (var doc in snapshot.docs) {
                var fav = doc.data() as Map<String, dynamic>;

                final itemId = fav["id"];
                final restaurantId = fav["restaurantId"];

                final data = await FirestoreGetters().getItemById(
                  restaurantId: restaurantId,
                  itemId: itemId,
                );

                if (data != null) {
                  items.add(
                    ItemModel.fromMap(data, itemId, restaurantId, null),
                  );
                }
              }

              log('fav items is : $items');
              if (isClosed) return;
              emit(GetFavouriteItemsLoaded(items: items));
            },
            onError: (e) {
              emit(GetFavouriteItemsFailure(message: e.toString()));
            },
          );
    } catch (e) {
      emit(GetFavouriteItemsFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
