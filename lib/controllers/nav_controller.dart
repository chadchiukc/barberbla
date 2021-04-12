import 'package:barberbla/pages/booking.dart';
import 'package:barberbla/pages/services.dart';
import 'package:get/get.dart';

class NavController extends GetxController {
  var _tabIndex = 0.obs;
  final navPages = [() => ServicePage(), () => BookingPage()];

  get selectedIndex => this._tabIndex.value;

  set selectedIndex(int index) => this._tabIndex.value = index;
}
