import 'package:barberbla/controllers/user_controller.dart';
import 'package:barberbla/models/booking_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {
  var bookingList = <BookingModel>[].obs;
  final UserController _user = Get.find<UserController>();

  @override
  void onInit() {
    fetchBooking();
    super.onInit();
  }

  void fetchBooking() async {
    bookingList.clear();
    EasyLoading.show(status: 'Loading...');
    try {
      QuerySnapshot _booking = await Database().getBooking(_user.user.id);
      _booking.docs.forEach((element) {
        bookingList.add(BookingModel.fromQueryDocumentnapshot(element));
      });
    } catch (e) {
      Get.snackbar(
          "Error during fetching from server", 'Please try again later...');
    }
    EasyLoading.dismiss();
  }
}
