import 'package:barberbla/models/booking_model.dart';
import 'package:barberbla/utils/database.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AdminBookingController extends GetxController {
  var bookingList = <BookingModel>[].obs;
  var shopList = [].obs;

  @override
  void onInit() {
    adminFetchShop();
    bookingList.bindStream(Database().bookingStream());
    super.onInit();
  }

  void adminFetchShop() async {
    shopList.clear();
    shopList.add('ALL');
    EasyLoading.show(status: 'Loading...');
    try {
      shopList.value = await Database().adminGetShops();
      shopList.add('All');
      shopList.sort();
    } catch (e) {
      Get.snackbar(
          "Error during fetching from server", 'Please try again later...');
    }
    EasyLoading.dismiss();
  }

  List<BookingModel> todayBooking(
      String shopName, RxList<BookingModel> bookingList) {
    var currentDate = DateTime.now();
    var todayBooking = bookingList.where((booking) =>
        booking.timestamp.toDate().year == currentDate.year &&
        booking.timestamp.toDate().month == currentDate.month &&
        booking.timestamp.toDate().day == currentDate.day);
    if (shopName != 'All') {
      todayBooking =
          todayBooking.where((booking) => booking.shopName == shopName);
    }
    print('todayBook');
    return todayBooking.toList();
  }

  int todayCount(String shopName, RxList<BookingModel> bookingList) {
    var currentDate = DateTime.now();
    var todayBooking = bookingList.where((booking) =>
        booking.timestamp.toDate().year == currentDate.year &&
        booking.timestamp.toDate().month == currentDate.month &&
        booking.timestamp.toDate().day == currentDate.day);
    if (shopName != 'All') {
      todayBooking =
          todayBooking.where((booking) => booking.shopName == shopName);
    }
    return todayBooking.toList().length;
  }

  int monthCount(String shopName, RxList<BookingModel> bookingList) {
    var currentDate = DateTime.now();
    var monthBooking = bookingList.where((booking) =>
        booking.timestamp.toDate().year == currentDate.year &&
        booking.timestamp.toDate().month == currentDate.month);
    if (shopName != 'All') {
      monthBooking =
          monthBooking.where((booking) => booking.shopName == shopName);
    }
    return monthBooking.toList().length;
  }
}
