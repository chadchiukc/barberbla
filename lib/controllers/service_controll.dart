import 'package:barberbla/models/service_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceController extends GetxController {
  var servicesList = <ServiceModel>[].obs;
  QuerySnapshot _services;

  @override
  void onInit() {
    addServices();
    super.onInit();
  }

  void addServices() async {
    EasyLoading.show(status: 'test.');
    try {
      _services = await Database().getServices();
      _services.docs.forEach((element) {
        // var ref = FirebaseStorage.instance.ref().child(element.data().);
        print(element.data());
        servicesList.add(ServiceModel.fromQueryDocumentnapshot(element));
      });
    } catch (e) {
      Get.snackbar("Error during fetching from server", e.message);
    }
    EasyLoading.dismiss();
  }
}
