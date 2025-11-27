import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delish/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<Map<String, dynamic>?> getCurrentUserInfo() async {
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) return null;

  String uid = user.uid;

  var doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

  if (!doc.exists) return null;

  return {'name': doc['name'], 'email': doc['email']};
}

UserModel? userModel;
