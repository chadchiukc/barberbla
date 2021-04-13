import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/nav_controller.dart';
import 'package:barberbla/controllers/user_controller.dart';
import 'package:barberbla/pages/admin.dart';
import 'package:barberbla/pages/services.dart';
import 'package:barberbla/pages/login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class Root extends StatelessWidget {
  final AuthController _authController = Get.put(AuthController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_authController.user != null) {
        _userController.syncFirebase(_authController.user);
      }
      return _authController.user == null
          ? Login()
          : _userController.user.privilege == 'admin'
          ? AdminPage()
          : ServicePage();
    });
  }
}
