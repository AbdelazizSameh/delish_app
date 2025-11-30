// firestore_getters.dart
// ملف منفصل لكل دوال الجلب (Read-Only)
// يمكنك استيراده في أي مكان: import 'firestore_getters.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;

import '../../../models/items_model.dart';

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
  Future<List<ItemModel>> getAllPopularItems() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      List<ItemModel> popularItems = [];

      // Step 1: Get all restaurants
      final restaurantsSnapshot = await db.collection('restaurants').get();

      for (var restaurantDoc in restaurantsSnapshot.docs) {
        final restaurantId = restaurantDoc.id;

        // Step 2: Get all categories inside this restaurant
        final categoriesSnapshot = await db
            .collection('restaurants')
            .doc(restaurantId)
            .collection('categories')
            .get();

        for (var categoryDoc in categoriesSnapshot.docs) {
          final categoryId = categoryDoc.id;

          final itemsSnapshot = await db
              .collection('restaurants')
              .doc(restaurantId)
              .collection('categories')
              .doc(categoryId)
              .collection('items')
              .where('isPopular', isEqualTo: true)
              .get();

          for (var itemDoc in itemsSnapshot.docs) {
            final data = itemDoc.data();

            popularItems.add(
              ItemModel.fromMap(
                data,
                itemDoc.id, // itemId
                restaurantId, // restaurantId
                categoryId,
              ),
            );
          }
        }
      }

      return popularItems;
    } catch (e) {
      developer.log("Error fetching popular items: $e");
      return [];
    }
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
  //=============================================================

  Future<Map<String, dynamic>?> getItemById({
    required String restaurantId,
    required String itemId,
  }) async {
    final db = FirebaseFirestore.instance;

    // نجيب كل الكاتيجوريز
    var categoriesSnapshot = await db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .get();

    for (var category in categoriesSnapshot.docs) {
      var itemDoc = await category.reference
          .collection('items')
          .doc(itemId)
          .get();

      if (itemDoc.exists) {
        return itemDoc.data();
      }
    }

    return null;
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
  Stream<List<Map<String, dynamic>>> getUserOrders(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) => doc.data()).toList();
        });
  }

  Stream<double> getTotalPriceOfOrder(String userId, String orderId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((doc) {
          if (!doc.exists) return 0;
          return (doc.data()?['totalPrice'] ?? 0).toDouble();
        });
  }

  Stream<Map<String, dynamic>?> getOrderDetailsStream(
    String userId,
    String orderId,
  ) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((doc) => doc.data());
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
  Future<Map<String, dynamic>?> getOrderDetails(
    String userId,
    String orderId,
  ) async {
    try {
      final doc = await db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .get();

      return doc.data(); // Map<String, dynamic>?
    } catch (e) {
      developer.log('خطأ في جلب الطلب: $e');
      return null;
    }
  }

  // =============================جلب حالة الطلب===============================================
  Stream<String> getOrderStatus(String userId, String orderId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots()
        .map((snapshot) => snapshot.data()!['status'] ?? '');
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
      final catregoryId = categoryDoc.id;
      var itemsSnapshot = await categoryDoc.reference.collection('items').get();

      for (var itemDoc in itemsSnapshot.docs) {
        allItems.add({
          "id": itemDoc.id,
          "catregoryId": catregoryId,
          ...itemDoc.data(),
        });
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
  // Stream<DocumentSnapshot> getOrderDetailsStream({
  //   required String userId,
  //   required String orderId,
  // }) {
  //   return db
  //       .collection('users')
  //       .doc(userId)
  //       .collection('orders')
  //       .doc(orderId)
  //       .snapshots();
  // }

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
