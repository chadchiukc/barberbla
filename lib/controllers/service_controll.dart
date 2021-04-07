import 'package:barberbla/models/service_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController extends GetxController {
  var servicesList = <ServiceModel>[];
  QuerySnapshot _services;
  ServiceModel _service;

  @override
  void onInit() {
    addServices();
    super.onInit();
  }

  void addServices() async {
    _services = await Database().getServices();
    _services.docs.forEach((element) {
      _service = ServiceModel.fromQueryDocumentnapshot(element);
      servicesList.add(_service);
    });
  }
}
