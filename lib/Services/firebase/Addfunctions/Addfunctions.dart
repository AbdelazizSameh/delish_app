// ignore_for_file: file_names

import 'dart:developer' as developer;
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ====================== Collections ======================
  CollectionReference get restaurantsCollection => db.collection('restaurants');

  // ====================== 1. إضافة مطعم ======================
  Future<DocumentReference> addRestaurant({
    required String name,
    required String imageUrl,
    required bool fastDelivery,
    required double rating,
    int ratingCount = 0,
  }) async {
    return await db.collection('restaurants').add({
      'name': name,
      'image': imageUrl,
      'fast_delivery': fastDelivery,
      'rating': rating,
      'ratingCount': ratingCount,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ====================== 2. إضافة تصنيف ======================
  Future<DocumentReference> addCategory({
    required String restaurantId,
    required String name,
    required String imageUrl,
  }) async {
    return await db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .add({
          'name': name,
          'image': imageUrl,
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  // ====================== 3. إضافة عنصر ======================
  Future<DocumentReference> addItem({
    required String restaurantId,
    required String categoryId,
    required String name,
    required String description,
    required double price,
    required double discount,
    required bool popular,
    String? imageUrl,
  }) async {
    final double priceAfterDiscount = price - (price * discount);

    return await db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .doc(categoryId)
        .collection('items')
        .add({
          'name': name,
          'description': description,
          'price': price,
          'discount': discount,
          'price_after_discount': priceAfterDiscount,
          'popular': popular,
          'image': imageUrl ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  // ====================== 4. إضافة طلب ======================
  Future<DocumentReference> addOrder({
    required String userId,
    required String restaurantId,
    required double totalPrice,
    required int quantity,
    required String name,
    String? imageUrl,
  }) async {
    return await db.collection('users').doc(userId).collection('orders').add({
      'restaurantId': restaurantId,
      'id': Random().nextInt(10000),
      'totalPrice': totalPrice,
      'quantity': quantity,
      'name': name,
      'image': imageUrl,
      'status': 'preparing',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // ====================== 5. إضافة مطعم للمفضلة ======================
  Future<void> addFavoriteRestaurant({
    required String userId,
    required String restaurantId,
    required String restaurantName,
  }) async {
    try {
      final favRef = db
          .collection('users')
          .doc(userId)
          .collection('favorites_restaurants');

      final exists = await _existsInFavorites(favRef, restaurantId);
      if (exists) {
        developer.log('المطعم "$restaurantName" موجود بالفعل في المفضلة');
        return;
      }

      await favRef.add({
        'id': restaurantId,
        'name': restaurantName,
        'saved_at': FieldValue.serverTimestamp(),
      });

      developer.log('تم إضافة "$restaurantName" للمفضلة');
    } catch (e) {
      developer.log('خطأ في إضافة المطعم للمفضلة: $e');
      rethrow;
    }
  }

  // ====================== 6. إضافة عنصر للمفضلة ======================
  Future<void> addFavoriteItem({
    required String userId,
    required String itemId,
    required String itemName,
    required String restaurantId,
  }) async {
    try {
      final favRef = db
          .collection('users')
          .doc(userId)
          .collection('favorites_items');

      final exists = await _existsInFavorites(favRef, itemId);
      if (exists) {
        developer.log('الصنف "$itemName" موجود بالفعل في المفضلة');
        return;
      }

      await favRef.add({
        'id': itemId,
        'name': itemName,
        'restaurantId': restaurantId,
        'saved_at': FieldValue.serverTimestamp(),
      });

      developer.log('تم إضافة "$itemName" للمفضلة');
    } catch (e) {
      developer.log('خطأ في إضافة الصنف للمفضلة: $e');
      rethrow;
    }
  }

  // ====================== 7. إزالة عنصر من المفضلة ======================
  Future<void> removeFavoriteItem({
    required String userId,
    required String itemId,
  }) async {
    try {
      final favRef = db
          .collection('users')
          .doc(userId)
          .collection('favorites_items');

      final docRef = await _getFavoriteDoc(favRef, itemId);
      if (docRef == null) {
        developer.log('الصنف غير موجود في المفضلة: $itemId');
        return;
      }

      await docRef.delete();
      developer.log('تم حذف الصنف من المفضلة: $itemId');
    } catch (e) {
      developer.log('خطأ في حذف الصنف: $e');
      rethrow;
    }
  }

  // ====================== 8. إزالة مطعم من المفضلة ======================
  Future<void> removeFavoriteRestaurant({
    required String userId,
    required String restaurantId,
  }) async {
    try {
      final favRef = db
          .collection('users')
          .doc(userId)
          .collection('favorites_restaurants');

      final docRef = await _getFavoriteDoc(favRef, restaurantId);
      if (docRef == null) {
        developer.log('المطعم غير موجود في المفضلة: $restaurantId');
        return;
      }

      await docRef.delete();
      developer.log('تم حذف المطعم من المفضلة: $restaurantId');
    } catch (e) {
      developer.log('خطأ في حذف المطعم: $e');
      rethrow;
    }
  }

  // ====================== Toggle Favorite (مطاعم) ======================
  Future<void> toggleFavoriteRestaurant({
    required String userId,
    required String restaurantId,
    required String restaurantName,
  }) async {
    final isFav = await isFavorite(
      userId: userId,
      type: 'restaurant',
      id: restaurantId,
    );
    isFav
        ? await removeFavoriteRestaurant(
            userId: userId,
            restaurantId: restaurantId,
          )
        : await addFavoriteRestaurant(
            userId: userId,
            restaurantId: restaurantId,
            restaurantName: restaurantName,
          );
  }

  // ====================== Toggle Favorite (أصناف) ======================
  Future<void> toggleFavoriteItem({
    required String userId,
    required String itemId,
    required String itemName,
    required String restaurantId,
  }) async {
    final isFav = await isFavorite(userId: userId, type: 'item', id: itemId);
    isFav
        ? await removeFavoriteItem(userId: userId, itemId: itemId)
        : await addFavoriteItem(
            userId: userId,
            itemId: itemId,
            itemName: itemName,
            restaurantId: restaurantId,
          );
  }

  // ====================== تقلب حالة الأوردر: preparing ↔ delivered ======================
  Future<void> toggleOrderCompletion({
    required String userId,
    required String orderId,
  }) async {
    try {
      final orderRef = db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      final snapshot = await orderRef.get();
      if (!snapshot.exists) {
        developer.log('الأوردر غير موجود: $orderId');
        return;
      }

      final currentStatus = snapshot.data()?['status'] as String?;

      // Only toggle between preparing and delivered
      if (currentStatus != 'preparing' && currentStatus != 'delivered') {
        developer.log(
          'لا يمكن تغيير حالة الأوردر إلا إذا كانت preparing أو delivered',
        );
        return;
      }

      final newStatus = (currentStatus == 'preparing')
          ? 'delivered'
          : 'preparing';

      await orderRef.update({
        'status': newStatus,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      developer.log(
        'تم تغيير حالة الأوردر $orderId من $currentStatus إلى: $newStatus',
      );
    } catch (e) {
      developer.log('خطأ في تقلب حالة الأوردر: $e');
      rethrow;
    }
  }

  // ====================== حذف أوردر معين إذا كان مكتمل فقط ======================
  Future<void> deleteCompletedOrder({
    required String userId,
    required String orderId,
  }) async {
    try {
      final orderRef = db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId);

      final snapshot = await orderRef.get();
      if (!snapshot.exists) {
        developer.log('الأوردر غير موجود: $orderId');
        return;
      }

      final status = snapshot.data()?['status'] as String?;
      if (status != 'delivered') {
        developer.log('الأوردر ليس مكتملًا، لا يمكن حذفه: $status');
        return;
      }

      await orderRef.delete();
      developer.log('تم حذف الأوردر المكتمل بنجاح: $orderId');
    } catch (e) {
      developer.log('خطأ في حذف الأوردر المكتمل: $e');
      rethrow;
    }
  }

  // ====================== تحقق من المفضلة  ======================
  Future<bool> isFavorite({
    required String userId,
    required String type,
    required String id,
  }) async {
    try {
      final collection = type == 'restaurant'
          ? 'favorites_restaurants'
          : 'favorites_items';
      final query = await db
          .collection('users')
          .doc(userId)
          .collection(collection)
          .where('id', isEqualTo: id)
          .limit(1)
          .get();
      return query.docs.isNotEmpty;
    } catch (e) {
      developer.log('خطأ في التحقق من المفضلة: $e');
      return false;
    }
  }

  // ====================== Helper: تحقق من وجود في المفضلة ======================
  Future<bool> _existsInFavorites(CollectionReference ref, String id) async {
    final query = await ref.where('id', isEqualTo: id).limit(1).get();
    return query.docs.isNotEmpty;
  }

  // ====================== Helper: جلب الـ Document للحذف ======================
  Future<DocumentReference?> _getFavoriteDoc(
    CollectionReference ref,
    String id,
  ) async {
    final query = await ref.where('id', isEqualTo: id).limit(1).get();
    return query.docs.isNotEmpty ? query.docs.first.reference : null;
  }
}
