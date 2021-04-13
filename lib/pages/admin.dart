import 'package:barberbla/controllers/admin_booking_controller.dart';
import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/pages/admin_booking.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminPage extends StatelessWidget {
  final AuthController _auth = Get.find<AuthController>();
  final AdminBookingController _admin = Get.put(AdminBookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text('Admin\'s Page'),
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
            child: Obx(
              () => ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  thickness: 1.5,
                  color: Colors.grey,
                ),
                itemCount: _admin.shopList.length,
                itemBuilder: (context, index) {
                  var shopName = _admin.shopList[index];
                  var todayCount =
                      _admin.todayCount(shopName, _admin.bookingList);
                  var monthCount =
                      _admin.monthCount(shopName, _admin.bookingList);
                  return ListTile(
                    title: Text(
                      shopName,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(decoration: TextDecoration.underline),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today\'s booking: $todayCount',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          'This month\'s booking: $monthCount',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                    trailing: TextButton(
                        onPressed: () {
                          Get.to(() => ShopBookingPage(), arguments: shopName);
                        },
                        child: Container(
                          width: 100,
                          child: Text(
                            'Check today\'s bookings',
                            maxLines: 2,
                          ),
                        )),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
