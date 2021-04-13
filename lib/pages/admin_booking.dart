import 'package:barberbla/controllers/admin_booking_controller.dart';
import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopBookingPage extends StatelessWidget {
  final AuthController _auth = Get.find<AuthController>();
  final AdminBookingController _admin = Get.find<AdminBookingController>();
  final _shopName = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text('$_shopName'),
        actions: [
          TextButton(
              onPressed: () {
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
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Obx(() {
              var todayBooking =
                  _admin.todayBooking(_shopName, _admin.bookingList);
              return todayBooking.length == 0
                  ? Center(
                      child: Text('No Booking yet for today'),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => Divider(
                        thickness: 1.5,
                        color: Colors.grey,
                      ),
                      itemCount: todayBooking.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            todayBooking[index].service,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          subtitle: Text(
                            todayBooking[index]
                                .timestamp
                                .toDate()
                                .toString()
                                .substring(11, 16),
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        );
                      },
                    );
            }),
          ),
        ),
      ),
    );
  }
}
