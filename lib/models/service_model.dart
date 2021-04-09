import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceModel {
  String id;
  String service;
  int fee;
  String imgName;

  ServiceModel({this.id, this.service, this.fee, this.imgName});

  ServiceModel.fromQueryDocumentnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    service = queryDocumentSnapshot.data()['service'];
    imgName = queryDocumentSnapshot.data()['img'];
    fee = queryDocumentSnapshot.data()['fee'];
  }
}
