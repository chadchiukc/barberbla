import 'package:barberbla/models/service_model.dart';
import 'package:barberbla/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot _doc =
          await _firestore.collection('users').doc(uid).get();
      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getServices() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('services').get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }
}
