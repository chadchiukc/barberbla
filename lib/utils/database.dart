import 'package:barberbla/models/booking_model.dart';
import 'package:barberbla/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "name": user.name,
        "email": user.email,
        "privilege": 'customer',
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
      QuerySnapshot querySnapshot = await _firestore
          .collection('services')
          .orderBy('service', descending: false)
          .get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getShops(String name) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('shops')
          .where('services', arrayContains: name)
          .get();
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> adminGetShops() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('shops').get();
      return querySnapshot.docs.map((e) => e.data()['name']).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getBooking(String uid) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('booking')
          .orderBy('timestamp', descending: true)
          .where('userId', isEqualTo: uid)
          .limit(15)
          .get();
      print(uid);
      return querySnapshot;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<BookingModel>> bookingStream() {
    return _firestore
        .collection('booking')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((event) {
      List<BookingModel> _bookingList = [];
      event.docs.forEach((element) {
        _bookingList.add(BookingModel.fromQueryDocumentnapshot(element));
      });
      return _bookingList;
    });
  }

  Future<bool> addBooking(String service, String shopId, TimeOfDay timeOfDay,
      String userId, String shopName) async {
    try {
      var currentTime = await getCurrentTime();
      await _firestore.collection('booking').add({
        'service': service,
        'shopId': shopId,
        'timestamp': Timestamp.fromDate(DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            timeOfDay.hour,
            timeOfDay.minute)),
        'userId': userId,
        'shopName': shopName,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<DateTime> getCurrentTime() async {
    try {
      DateTime currentTime = await NTP.now();
      return currentTime;
    } catch (e) {
      return DateTime.now();
    }
  }
}
