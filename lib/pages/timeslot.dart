import 'package:barberbla/controllers/shops_controller.dart';
import 'package:barberbla/controllers/time_picker_controller.dart';
import 'package:barberbla/pages/confirm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TimeSlot extends StatelessWidget {
  const TimeSlot({
    Key key,
    @required ShopController shop,
    @required TimePickerController time,
    @required index,
  })  : _shop = shop,
        _time = time,
        index = index,
        super(key: key);

  final ShopController _shop;
  final TimePickerController _time;
  final index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Column(
          children: [
            Text('Step 3: Select the time'),
            Text('${_shop.shopList[index].name}')
          ],
        ),
      ),
      body: Column(
        children: [
          Obx(() {
            return Flexible(
              child: _time.timeslot.length == 0
                  ? Center(
                      child: Text('No more bookings for today'),
                    )
                  : GridView.builder(
                      itemCount: _time.timeslot.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: getValueForScreenType(
                              context: context,
                              mobile: 4,
                              desktop: 10,
                              tablet: 7),
                          childAspectRatio: 2.5),
                      itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              _time.selectIndex(index);
                            },
                            child: Obx(() {
                              String hour =
                                  _time.timeslot[index].hour.toString();
                              String min = _time.timeslot[index].minute == 0
                                  ? '00'
                                  : _time.timeslot[index].minute.toString();
                              return Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 2)),
                                color: _time.selectedIndex.value == index
                                    ? Color.fromARGB(255, 77, 208, 225)
                                    : Colors.transparent,
                                child: Center(
                                    child: Text(
                                  '$hour:$min',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: _time.selectedIndex.value == index
                                          ? Colors.white
                                          : Colors.black),
                                )),
                              );
                            }),
                          )),
            );
          }),
          Divider(
            color: Colors.black,
          ),
          Container(
            width: getValueForScreenType(
                context: context,
                mobile: Get.width * 0.6,
                tablet: Get.width * 0.4,
                desktop: Get.width * 0.3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          primary: Color.fromARGB(255, 77, 208, 225),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel')),
                  ),
                ),
                Obx(() {
                  if (_time.timeslot.length > 0) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              primary: Color.fromARGB(255, 77, 208, 225),
                            ),
                            onPressed: () {
                              Get.off(() => ConfirmPage(),
                                  arguments: _time
                                      .timeslot[_time.selectedIndex.value]);
                            },
                            child: Text('Confirm')),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
