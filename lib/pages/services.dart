// import 'package:barberbla/controllers/booking_controller.dart';
import 'package:barberbla/controllers/nav_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:barberbla/pages/shops.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:barberbla/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ServicePage extends StatelessWidget {
  final ServiceController _service = Get.put(ServiceController());
  // final BookingController _booking = Get.put(BookingController());
  final NavController _nav = Get.put(NavController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          centerTitle: true,
          title: Text('Step 1: Select the service'),
        ),
        body: Container(
          decoration: background,
          child: SafeArea(
            child: Container(
              child: Obx(() => ListView.builder(
                  itemCount: _service.servicesList.length,
                  itemBuilder: (context, index) {
                    String img = _service.servicesList[index].imgName;
                    String fee = _service.servicesList[index].fee.toString();
                    return GestureDetector(
                      onTap: () {
                        _service.selectService(index);
                        Get.to(() => ShopPage());
                      },
                      child: Container(
                        width: getValueForScreenType(
                            context: context,
                            mobile: Get.width,
                            tablet: Get.width * 0.6,
                            desktop: Get.width * 0.3),
                        child: Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                    height: 250,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/$img.jpg',
                                    )),
                                Text(
                                  _service.servicesList[index].service,
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                                Text(
                                  'HK\$ $fee',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Colors.grey[600],
                                      ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ),
        ),
        bottomNavigationBar: BottomNav());
  }
}
