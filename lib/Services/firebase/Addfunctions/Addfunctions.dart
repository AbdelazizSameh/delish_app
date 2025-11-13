// ignore_for_file: file_names

import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
class FirestoreService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  CollectionReference get restaurantsCollection => db.collection('restaurants');

  // ====================== 1. إضافة مطعم ======================
  Future<DocumentReference> addRestaurant({
    required String name,
    required String imageUrl,
    required bool isFast,
    required double rating,
    int ratingCount = 0,
  }) async {
    return await db.collection('restaurants').add({
      'name': name,
      'image': imageUrl,
      'isFast': isFast,
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

  // ====================== 3. إضافة عنصر (void) ======================
  Future<void> addItem({
    required String restaurantId,
    required String categoryId,
    required String name,
    required String description,
    required double price,
    required double discount,
    required bool isPopular,
    String? imageUrl,
  }) async {
    final double priceAfterDiscount = price - (price * discount);

    await db
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
          'priceAfterDiscount': priceAfterDiscount,
          'isPopular': isPopular,
          'image': imageUrl ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
  }

  // ====================== 4. إضافة طلب ======================
  Future<DocumentReference> addOrder({
    required String userId,
    required String restaurantId,
    required String restaurantName,
    required List<Map<String, dynamic>> items,
    required double totalPrice,
  }) async {
    return await db.collection('users').doc(userId).collection('orders').add({
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'items': items,
      'totalPrice': totalPrice,
      'status': 'pending',
      'orderTime': FieldValue.serverTimestamp(),
    });
  }

  // ====================== 5. إضافة مطعم للمفضلة ======================
  Future<void> addFavoriteRestaurant({
    required String userId,
    required String restaurantId,
    required String restaurantName,
  }) async {
    final favRef = db.collection('users').doc(userId).collection('favorites');
    final query = await favRef
        .where('type', isEqualTo: 'restaurant')
        .where('restaurantId', isEqualTo: restaurantId)
        .get();

    if (query.docs.isNotEmpty) {
      log('المطعم موجود بالفعل في المفضلة');
      return;
    }

    await favRef.add({
      'type': 'restaurant',
      'restaurantId': restaurantId,
      'restaurantName': restaurantName,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // ====================== 6. إضافة عنصر للمفضلة ======================
  Future<void> addFavoriteItem({
    required String userId,
    required String restaurantId,
    required String categoryId,
    required String itemId,
    required String itemName,
  }) async {
    final favRef = db.collection('users').doc(userId).collection('favorites');
    final query = await favRef
        .where('type', isEqualTo: 'item')
        .where('itemId', isEqualTo: itemId)
        .get();

    if (query.docs.isNotEmpty) {
      log('العنصر موجود بالفعل في المفضلة');
      return;
    }

    await favRef.add({
      'type': 'item',
      'restaurantId': restaurantId,
      'categoryId': categoryId,
      'itemId': itemId,
      'itemName': itemName,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  // ====================== 7. إزالة عنصر من المفضلة ======================
  Future<void> removeFavoriteItem({
    required String userId,
    required String itemId,
  }) async {
    final favRef = db.collection('users').doc(userId).collection('favorites');
    final query = await favRef
        .where('type', isEqualTo: 'item')
        .where('itemId', isEqualTo: itemId)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  // ====================== 8. إزالة مطعم من المفضلة ======================
  Future<void> removeFavoriteRestaurant({
    required String userId,
    required String restaurantId,
  }) async {
    final favRef = db.collection('users').doc(userId).collection('favorites');
    final query = await favRef
        .where('type', isEqualTo: 'restaurant')
        .where('restaurantId', isEqualTo: restaurantId)
        .get();

    for (var doc in query.docs) {
      await doc.reference.delete();
    }
  }

  // ====================== 9. جلب كل المطاعم ======================
  Stream<QuerySnapshot> getAllRestaurants() {
    return db
        .collection('restaurants')
        .orderBy('rating', descending: true)
        .snapshots();
  }

  // ====================== 10. جلب المطاعم السريعة فقط ======================
  Stream<QuerySnapshot> getFastRestaurants() {
    return db
        .collection('restaurants')
        .where('isFast', isEqualTo: true) // مُصحح
        .orderBy('rating', descending: true)
        .snapshots();
  }

  // ====================== 11. جلب كل العناصر ======================
  Stream<QuerySnapshot> getAllItems() {
    return db.collectionGroup('items').snapshots();
  }

  // ====================== 12. جلب العناصر المشهورة ======================
  Stream<QuerySnapshot> getPopularItems() {
    return db
        .collectionGroup('items')
        .where('isPopular', isEqualTo: true)
        .orderBy('priceAfterDiscount')
        .snapshots();
  }

  // ====================== 13. جلب التصنيفات مع عدد العناصر ======================
  Stream<List<Map<String, dynamic>>> getCategoriesWithCount(String restaurantId) {
    final categoriesRef = db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories');

    return categoriesRef.snapshots().asyncMap((snapshot) async {
      final List<Map<String, dynamic>> result = [];
      for (var catDoc in snapshot.docs) {
        final catData = catDoc.data();
        final itemsSnapshot = await catDoc.reference.collection('items').get();
        final itemCount = itemsSnapshot.docs.length;

        result.add({
          'categoryId': catDoc.id,
          'name': catData['name'] ?? '',
          'image': catData['image'] ?? '',
          'itemCount': itemCount,
        });
      }
      return result;
    });
  }

  // ====================== 14. جلب تفاصيل عنصر ======================
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
      log('خطأ في جلب العنصر: $e');
      return null;
    }
  }

  // ====================== 15. جلب مفضلة العناصر ======================
  Stream<QuerySnapshot> getFavoriteItems(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .where('type', isEqualTo: 'item')
        .orderBy('addedAt', descending: true)
        .snapshots();
  }

  // ====================== 16. جلب مفضلة المطاعم ======================
  Stream<QuerySnapshot> getFavoriteRestaurants(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .where('type', isEqualTo: 'restaurant')
        .orderBy('addedAt', descending: true)
        .snapshots();
  }

  // ====================== 17. جلب طلبات اليوزر ======================
  Stream<QuerySnapshot> getUserOrders(String userId) {
    return db
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderTime', descending: true)
        .snapshots();
  }

  // ====================== 18. جلب تفاصيل طلب ======================
  Future<DocumentSnapshot?> getOrderDetails(String userId, String orderId) async {
    try {
      return await db
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .get();
    } catch (e) {
      log('خطأ في جلب الطلب: $e');
      return null;
    }
  }

  // ====================== 19. جلب التصنيفات (بدون العدد) ======================
  Stream<QuerySnapshot> getCategories(String restaurantId) {
    return db
        .collection('restaurants')
        .doc(restaurantId)
        .collection('categories')
        .orderBy('name')
        .snapshots();
  }

  // ====================== 20. جلب مطعم بالـ ID ======================
  Future<DocumentSnapshot?> getRestaurantById(String restaurantId) async {
    try {
      return await db.collection('restaurants').doc(restaurantId).get();
    } catch (e) {
      log('خطأ في جلب المطعم: $e');
      return null;
    }
  }

  // ====================== 21. تحقق من المفضلة ======================
  Future<bool> isFavorite({
    required String userId,
    required String type,
    required String id,
  }) async {
    final field = type == 'item' ? 'itemId' : 'restaurantId';
    final query = await db
        .collection('users')
        .doc(userId)
        .collection('favorites')
        .where('type', isEqualTo: type)
        .where(field, isEqualTo: id)
        .get();
    return query.docs.isNotEmpty;
  }
    // ====================== 21.جلب العناصر لمطعم معين ======================
    Future<List<Map<String, dynamic>>> fetchRestaurantItemsOnly(String restaurantId) async {
    try {
      final List<Map<String, dynamic>> allItems = [];

      // 1. جلب كل التصنيفات
      final categoriesSnapshot = await db
          .collection('restaurants')
          .doc(restaurantId)
          .collection('categories')
          .get();

      // 2. لكل تصنيف → جلب العناصر (بدون إضافة categoryName)
      for (var catDoc in categoriesSnapshot.docs) {
        final itemsSnapshot = await db
            .collection('restaurants')
            .doc(restaurantId)
            .collection('categories')
            .doc(catDoc.id)
            .collection('items')
            .get();

        for (var itemDoc in itemsSnapshot.docs) {
          final itemData = itemDoc.data();
          itemData['id'] = itemDoc.id;
          allItems.add(itemData);
        }
      }

      return allItems;

    } catch (e) {
      log("خطأ في جلب العناصر: $e");
      rethrow;
    }
  }


}