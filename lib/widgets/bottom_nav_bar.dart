import 'package:barberbla/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  final NavController _nav = Get.find<NavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.amber[200],
          backgroundColor: Colors.red[400],
          onTap: (index) {
            if (_nav.selectedIndex != index) {
              Get.offAll(_nav.navPages[index]);
            }
            _nav.selectedIndex = index;
          },
          currentIndex: _nav.selectedIndex,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Services'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Booking'),
          ],
        ));
  }
}
