import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String service;
  int fee;
  String imgUrl;

  ServiceModel({this.id, this.service, this.fee, this.imgUrl});

  ServiceModel.fromQueryDocumentnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    service = queryDocumentSnapshot.data()['service'];
    imgUrl = queryDocumentSnapshot.data()['img'];
    fee = queryDocumentSnapshot.data()['fee'];
  }
}
