// firestore_getters.dart
// ملف منفصل لكل دوال الجلب (Read-Only)
// يمكنك استيراده في أي مكان: import 'firestore_getters.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

class FirestoreGetters {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  // ====================== 1. جلب كل المطاعم ======================
  Stream<QuerySnapshot> getAllRestaurants() {
    return db.collection('restaurants').snapshots();
  }

  // ====================== 2. جلب المطاعم السريعة ======================
  Stream<QuerySnapshot> getFastRestaurants() {
    return db
        .collection('restaurants')
        .where('isFast', isEqualTo: true)
        .snapshots();
  }

  // ====================== 3. جلب كل العناصر (collection group) ======================
  Stream<QuerySnapshot> getAllItems() {
    return db.collectionGroup('items').snapshots();
  }

  // ====================== 4. جلب العناصر المشهورة ======================
  Stream<QuerySnapshot> getPopularItems() {
    return db
        .collection('items')
        .where('isPopular', isEqualTo: true)
        .snapshots();
  }

  // ====================== 5. جلب التصنيفات مع عدد العناصر ======================
  Stream<List<Map<String, dynamic>>> getCategoriesWithCount(
    String restaurantId,
  ) {
    final categoriesRef = db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories');

    return categoriesRef.snapshots().asyncMap((snapshot) async {
      final List<Map<String, dynamic>> result = [];
      for (var catDoc in snapshot.docs) {
        final catData = catDoc.data();
        final itemsCount = await catDoc.reference
            .collection('items')
            .count()
            .get();
        result.add({
          'categoryId': catDoc.id,
          'name': catData['name'] ?? '',
          'image': catData['image'] ?? '',
          'itemCount': itemsCount.count,
        });
      }
      return result;
    });
  }

  // ====================== 6. جلب تفاصيل عنصر (مرة واحدة) ======================
  Future<DocumentSnapshot?> getItemDetails({
    required String restaurantId,
    required String categoryId,
    required String itemId,
  }) async {
    try {
      return await db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .doc(categoryId)
          .collection('items')
          .doc(itemId)
          .get();
    } catch (e) {
      developer.log('خطأ في جلب العنصر: $e');
      return null;
    }
  }

  // ====================== 7. جلب مفضلة العناصر ======================
  Stream<QuerySnapshot> getFavoriteItems(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('favorites_items')
        .orderBy('saved_at', descending: true)
        .snapshots();
  }

  // ====================== 8. جلب مفضلة المطاعم ======================
  Stream<QuerySnapshot> getFavoriteRestaurants(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('favorites_restaurants')
        .orderBy('saved_at', descending: true)
        .snapshots();
  }

  //============================================================================
  Future<Map<String, dynamic>?> getRestaurantById(String restaurantId) async {
  try {
    final doc = await db.collection('restaurants').doc(restaurantId).get();
    return doc.data();
  } catch (e) {
    developer.log('خطأ في جلب المطعم: $e');
    return null;
  }
}

  // ====================== 9. جلب طلبات اليوزر ======================
  Stream<QuerySnapshot> getUserOrders(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ====================== 10. جلب الأوردرات "جاري التحضير" ======================
  Stream<QuerySnapshot> getPreparingOrders(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .where('status', isEqualTo: 'preparing')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ====================== 11. جلب الأوردرات "مكتملة" ======================
  Stream<QuerySnapshot> getCompletedOrders(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .where('status', isEqualTo: 'delivered')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  // ====================== 12. جلب تفاصيل طلب (مرة واحدة) ======================
  Future<DocumentSnapshot?> getOrderDetails(
    String userId,
    String orderId,
  ) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .get();
    } catch (e) {
      developer.log('خطأ في جلب الطلب: $e');
      return null;
    }
  }

  // ====================== 13. جلب التصنيفات (بدون العدد) ======================
  Stream<QuerySnapshot> getCategories(String restaurantId) {
    return db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .orderBy('name')
        .snapshots();
  }

  //=====================================================================
  /// all items im restautrant
  Future<List<Map<String, dynamic>>> getRestaurantItems(
    String restaurantId,
  ) async {
    List<Map<String, dynamic>> allItems = [];

    var categoriesSnapshot = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .get();

    for (var categoryDoc in categoriesSnapshot.docs) {
      var itemsSnapshot = await categoryDoc.reference.collection('items').get();

      for (var itemDoc in itemsSnapshot.docs) {
        allItems.add({"id": itemDoc.id, ...itemDoc.data()});
      }
    }

    return allItems;
  }

  // ====================== 14. جلب مطعم بالـ ID (مرة واحدة) ======================
  // Future<DocumentSnapshot?> getRestaurantById(String restaurantId) async {
  //   try {
  //     return await db.collection('restaurants').doc(restaurantId).get();
  //   } catch (e) {
  //     developer.log('خطأ في جلب المطعم: $e');
  //     return null;
  //   }
  // }

  // ====================== 15. تحقق من المفضلة (مرة واحدة) ======================
  Future<bool> isFavorite({
    required String userId,
    required String type, // 'restaurant' or 'item'
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

  // ====================== 16. تحقق من المفضلة (تحديث فوري) ======================
  Stream<bool> isFavoriteStream({
    required String userId,
    required String type,
    required String id,
  }) {
    final collection = type == 'restaurant'
        ? 'favorites_restaurants'
        : 'favorites_items';

    return db
        .collection('users')
        .doc(userId)
        .collection(collection)
        .where('id', isEqualTo: id)
        .snapshots()
        .map((snapshot) => snapshot.docs.isNotEmpty);
  }

  // ====================== 17. جلب تفاصيل طلب (تحديث فوري) ======================
  Stream<DocumentSnapshot> getOrderDetailsStream({
    required String userId,
    required String orderId,
  }) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots();
  }

  // ====================== 18. جلب العناصر لمطعم معين (مرة واحدة) ======================
  Future<List<Map<String, dynamic>>> fetchRestaurantItemsOnly(
    String restaurantId,
  ) async {
    try {
      final List<Map<String, dynamic>> allItems = [];
      final categoriesSnapshot = await db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();

      for (var catDoc in categoriesSnapshot.docs) {
        final itemsSnapshot = await catDoc.reference.collection('items').get();
        for (var itemDoc in itemsSnapshot.docs) {
          final data = Map<String, dynamic>.from(itemDoc.data());
          data['id'] = itemDoc.id;
          data['categoryId'] = catDoc.id;
          allItems.add(data);
        }
      }
      return allItems;
    } catch (e) {
      developer.log('خطأ في جلب العناصر: $e');
      rethrow;
    }
  }
}
