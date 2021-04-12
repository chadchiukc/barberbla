import 'package:barberbla/models/service_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController extends GetxController {
  var servicesList = <ServiceModel>[].obs;
  var selectedService = ServiceModel().obs;
  QuerySnapshot _services;

  @override
  void onInit() {
    addServices();
    super.onInit();
  }

  void addServices() async {
    EasyLoading.show(status: 'Loading...');
    try {
      _services = await Database().getServices();
      _services.docs.forEach((element) {
        servicesList.add(ServiceModel.fromQueryDocumentnapshot(element));
      });
    } catch (e) {
      Get.snackbar(
          "Error during fetching from server", 'Please try again later...');
    }
    EasyLoading.dismiss();
  }

  void selectService(int index) {
    selectedService.value = ServiceModel(
        fee: servicesList[index].fee, service: servicesList[index].service);
  }
}
