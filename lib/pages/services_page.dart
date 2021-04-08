import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  // final AuthController _auth = Get.find<AuthController>();
  final AuthController _auth = Get.put(AuthController());
  final ServiceController _service = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Step 1: Select the service'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.dstATop,
              ),
              image: AssetImage('assets/images/login_background.jpeg'),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Container(
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    _auth.signout();
                  },
                  child: Text('logout')),
              // child: Obx(() => ListView.builder(
              //     itemCount: _service.servicesList.length,
              //     itemBuilder: (context, index) {
              //       // print(_service.servicesList[index].imgUrl);
              //       return Image.network(_service.servicesList[index].imgName);
              //     })),
            ),
          ),
        ),
      ),
    );
  }
}
