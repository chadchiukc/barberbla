import 'package:barberbla/controllers/service_controll.dart';
import 'package:barberbla/controllers/shops_controller.dart';
import 'package:barberbla/controllers/time_picker_controller.dart';
import 'package:barberbla/pages/timeslot.dart';
import 'package:barberbla/widgets/background.dart';
import 'package:barberbla/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShopPage extends StatelessWidget {
  final ShopController _shop = Get.put(ShopController());
  final ServiceController _service = Get.find<ServiceController>();
  final TimePickerController _time = Get.put(TimePickerController());

  @override
  Widget build(BuildContext context) {
    _shop.addShops(_service.selectedService.value.service);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text('Step 2: Select the shop'),
      ),
      body: Container(
        decoration: background,
        child: Obx(
          () {
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(
                thickness: 1.5,
                color: Colors.grey,
              ),
              itemCount: _shop.shopList.length,
              itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _time.updateTime(_shop.shopList[index].openHour);
                  _shop.selectShop(index);
                  Get.dialog(Dialog(
                    insetPadding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.1, horizontal: 0),
                    child: TimeSlot(shop: _shop, time: _time, index: index),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 13, left: 15, right: 15, bottom: 5),
                  child: Container(
                    height: 150,
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Barberbla ${_shop.shopList[index].name}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  Container(
                                    width: Get.width * 0.5,
                                    child: Text(
                                      _shop.shopList[index].address,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.update_outlined),
                                  Text(_shop.shopList[index].openHour),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Image(
                          height: 150,
                          width: 150,
                          fit: BoxFit.contain,
                          image: AssetImage(
                              'assets/images/${_shop.shopList[index].img}.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
