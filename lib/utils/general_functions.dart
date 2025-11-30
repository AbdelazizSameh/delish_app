import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delish/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';


UserModel? userModel;
Future<Map<String, dynamic>?> getCurrentUserInfo() async {
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) return null;

  String uid = user.uid;

  var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (!doc.exists) return null;

  return {'name': doc['name'], 'email': doc['email']};
}

List<String> restaurantsIDs = [];

Future<void> getAllRestaurantsID() async {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  try {
    final snapshot = await db.collection('restaurants').get();
    restaurantsIDs = snapshot.docs.map((doc) => doc.id).toList();

    log(restaurantsIDs.toString());
  } catch (e) {
    log("Error fetching restaurant IDs: $e");
  }
}
  String formatDateTime(DateTime dateTime) {
    final hour = dateTime.hour > 12 ? dateTime.hour - 12 : dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
