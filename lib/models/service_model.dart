import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String service;
  int fee;
  String imgUrl;

  ServiceModel({this.id, this.service, this.fee, this.imgUrl});

  ServiceModel.fromQueryDocumentnapshot(
      QueryDocumentSnapshot documentSnapshot) {
    id = documentSnapshot.id;
    service = documentSnapshot.data()['service'];
    imgUrl = documentSnapshot.data()['img_url'];
    fee = documentSnapshot.data()['fee'];
  }
}
