import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String email;
  String privilege;

  UserModel({this.id, this.name, this.email, this.privilege});

  UserModel.fromDocumentSnapshot({DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    email = documentSnapshot['email'];
    privilege = documentSnapshot['privilege'];
  }
}
