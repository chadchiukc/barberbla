import 'package:barberbla/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimePickerController extends GetxController {
  var timeslot = <TimeOfDay>[].obs;
  var selectedIndex = 0.obs;

  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  void updateTime(String openHour) async {
    selectedIndex.value = 0;
    timeslot.clear();
    var currentTime = await Database().getCurrentTime();
    // var currentTime = DateTime(2021, 4, 10, 15, 30);
    var compareTime = currentTime.hour * 60 + currentTime.minute >
            int.tryParse(openHour.substring(0, 2)) * 60 +
                int.tryParse(openHour.substring(2, 4))
        ? TimeOfDay(hour: currentTime.hour, minute: currentTime.minute)
        : TimeOfDay(
            hour: int.tryParse(openHour.substring(0, 2)),
            minute: int.tryParse(openHour.substring(2, 4)));
    var startMin =
        compareTime.minute ~/ 15 >= 3 ? 0 : (1 + compareTime.minute ~/ 15) * 15;
    var startHour =
        compareTime.minute ~/ 15 >= 3 ? compareTime.hour + 1 : compareTime.hour;
    final startTime = TimeOfDay(hour: startHour, minute: startMin);
    final endTime = TimeOfDay(
        hour: int.tryParse(openHour.substring(5, 7)),
        minute: int.tryParse(openHour.substring(7, 9)) - 1);
    final step = Duration(minutes: 15);

    if (currentTime.hour * 60 + currentTime.minute + 15 <
        int.tryParse(openHour.substring(5, 7)) * 60 +
            int.tryParse(openHour.substring(7, 9))) {
      final times = getTimes(startTime, endTime, step).toList();
      times.forEach((element) {
        timeslot.add(element);
      });
    }
  }

  void selectIndex(int index) {
    selectedIndex.value = index;
  }
}
