import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  String id;
  String service;
  String shopName;
  Timestamp timestamp;

  BookingModel({this.id, this.service, this.shopName, this.timestamp});

  BookingModel.fromQueryDocumentnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    service = queryDocumentSnapshot.data()['service'];
    shopName = queryDocumentSnapshot.data()['shopName'];
    timestamp = queryDocumentSnapshot.data()['timestamp'];
  }
}
