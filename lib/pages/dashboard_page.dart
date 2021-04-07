import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/location_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  // final AuthController _auth = Get.find<AuthController>();
  final LocationController _locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Center(
          child: Column(
            children: [
              // ElevatedButton(child: Text('logout'), onPressed: _auth.signout),
              ElevatedButton(
                child: Text('Request for your location'),
                onPressed: _locationController.getLocation,
              ),
              Obx(() {
                print('test');
                return Text(_locationController.position.toString());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
