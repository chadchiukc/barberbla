import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  // final AuthController _auth = Get.find<AuthController>();
  final AuthController _auth = Get.put(AuthController());
  // final ServiceController _service = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ServiceController>(
      init: ServiceController(),
      initState: (_) {
        ServiceController().addServices();
      },
      builder: (data) {
        return SafeArea(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  ElevatedButton(
                      child: Text('logout'),
                      onPressed: () {
                        data.servicesList.forEach((element) {
                          print(element);
                        });
                        // _auth.signout();
                      }),
                  // ElevatedButton(
                  //     child: Text('Request for your location'), onPressed: () {})
                  // Text(data.servicesList[0].service)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
