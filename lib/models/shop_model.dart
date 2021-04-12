import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String id;
  String address;
  GeoPoint latLon;
  String img;
  String name;
  String openHour;

  ShopModel(
      {this.id, this.address, this.latLon, this.img, this.name, this.openHour});

  ShopModel.fromQueryDocumentnapshot(
      QueryDocumentSnapshot queryDocumentSnapshot) {
    id = queryDocumentSnapshot.id;
    address = queryDocumentSnapshot.data()['address'];
    latLon = queryDocumentSnapshot.data()['lat_lon'];
    img = queryDocumentSnapshot.data()['img'];
    name = queryDocumentSnapshot.data()['name'];
    openHour = queryDocumentSnapshot.data()['openHour'];
  }
}
