import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/pages/services_page.dart';
import 'package:barberbla/pages/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  // final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => _authController.user == null ? Login() : DashboardPage());
  }
}
