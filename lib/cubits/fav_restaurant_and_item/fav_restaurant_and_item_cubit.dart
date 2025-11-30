import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../Services/firebase/Addfunctions/Addfunctions.dart';

part 'fav_restaurant_and_item_state.dart';

class FavRestaurantAndItemCubit extends Cubit<FavRestaurantAndItemState> {
  final FirestoreService firestoreService;

  FavRestaurantAndItemCubit({required this.firestoreService})
    : super(FavRestaurantAndItemInitial());

  Future<void> loadFavorites(String userId) async {
    emit(FavRestaurantAndItemLoading());
    try {
      final restaurantsQuery = await firestoreService.db
          .collection('users')
          .doc(userId)
          .collection('favorites_restaurants')
          .get();
      final restaurantIds = restaurantsQuery.docs
          .map((doc) => doc['id'] as String)
          .toList();

      final itemsQuery = await firestoreService.db
          .collection('users')
          .doc(userId)
          .collection('favorites_items')
          .get();
      final itemIds = itemsQuery.docs
          .map((doc) => doc['id'] as String)
          .toList();

      emit(
        FavRestaurantAndItemLoaded(
          favoriteRestaurants: restaurantIds,
          favoriteItems: itemIds,
        ),
      );
    } catch (e) {
      emit(FavRestaurantAndItemError('خطأ في تحميل المفضلة: $e'));
    }
  }

  Future<void> toggleFavorite({
    required String userId,
    required String type, 
    required String id,
    String? name,
    String? restaurantId, 
  }) async {
    emit(FavRestaurantAndItemLoading());

    try {
      if (type == 'restaurant') {
        final isFav = await firestoreService.isFavorite(
          userId: userId,
          type: 'restaurant',
          id: id,
        );
        if (isFav) {
          await firestoreService.removeFavoriteRestaurant(
            userId: userId,
            restaurantId: id,
          );
        } else {
          await firestoreService.addFavoriteRestaurant(
            userId: userId,
            restaurantId: id,
            restaurantName: name ?? '',
          );
        }
      } else if (type == 'item') {
        final isFav = await firestoreService.isFavorite(
          userId: userId,
          type: 'item',
          id: id,
        );
        if (isFav) {
          await firestoreService.removeFavoriteItem(userId: userId, itemId: id);
        } else {
          await firestoreService.addFavoriteItem(
            userId: userId,
            itemId: id,
            itemName: name ?? '',
            restaurantId: restaurantId ?? '',
          );
        }
      }

      // Reload after toggle
      await loadFavorites(userId);
    } catch (e) {
      if (isClosed) return;
      emit(FavRestaurantAndItemError('خطأ في تحديث المفضلة: $e'));
    }
  }

  Future<bool> isFavorite({
    required String userId,
    required String type,
    required String id,
  }) async {
    return await firestoreService.isFavorite(
      userId: userId,
      type: type,
      id: id,
    );
  }
}
