import 'package:barberbla/controllers/auth_controller.dart';
import 'package:barberbla/controllers/service_controll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashboardPage extends StatelessWidget {
  final AuthController _auth = Get.find<AuthController>();
  // final AuthController _auth = Get.put(AuthController());
  final ServiceController _service = Get.put(ServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            child: Obx(() => ListView.builder(
                itemCount: _service.servicesList.length,
                itemBuilder: (context, index) {
                  // print(_service.servicesList[index].imgUrl);
                  String img = _service.servicesList[index].imgName;
                  String fee = _service.servicesList[index].fee.toString();
                  return GestureDetector(
                    onTap: () {
                      print('test');
                    },
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                height: 250,
                                width: 400,
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/$img.jpg',
                                )),
                            Text(_service.servicesList[index].service),
                            Text('\$ $fee'),
                          ],
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
