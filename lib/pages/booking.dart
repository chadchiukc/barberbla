import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/booking_controller.dart';
import 'package:barberbla/controllers/nav_controller.dart';
import 'package:barberbla/controllers/user_controller.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:barberbla/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPage extends StatelessWidget {
  final UserController _user = Get.find<UserController>();
  // final BookingController _booking = Get.find<BookingController>();
  final BookingController _booking = Get.put(BookingController());
  final AuthController _auth = Get.find<AuthController>();
  final NavController _nav = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text('${_user.user.name.capitalizeFirst}\'s Booking'),
        actions: [
          TextButton(
              onPressed: () {
                _nav.selectedIndex = 0;
                _auth.signout();
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Container(
        decoration: background,
        child: SafeArea(
          child: Obx(() => _booking.bookingList.length == 0
              ? Center(
                  child: Text('No booking yet...'),
                )
              : ListView.builder(
                  itemCount: _booking.bookingList.length,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          shadowColor: Colors.amber[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                              side: BorderSide(color: Colors.black)),
                          color: Colors.transparent,
                          elevation: 4,
                          child: ListTile(
                            title: Text(
                              '${_booking.bookingList[index].service} at ${_booking.bookingList[index].shopName}',
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                                '${_booking.bookingList[index].timestamp.toDate().toString().substring(0, 16)}'),
                          ),
                        ),
                      ))),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
