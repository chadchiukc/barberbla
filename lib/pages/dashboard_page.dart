import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  final AuthController _auth = Get.find<AuthController>();
  final ServiceController _service = Get.put(ServiceController());
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
      child: ElevatedButton(child: Text('logout'), onPressed: _auth.signout),
    ));
  }
}
