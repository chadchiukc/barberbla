import 'package:barberbla/widgets/background.dart';
import 'package:barberbla/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessPage extends StatelessWidget {
  final _args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        centerTitle: true,
        title: Text('Reserved Successfully'),
      ),
      body: Container(
        decoration: background,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  height: 350,
                  width: 350,
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/barberbla.png'),
                ),
                Text(
                  'You\'re successfully reserved',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  'at ${_args[0].hour} : ${_args[0].minute.toString().length == 1 ? '00' : _args[0].minute} in ${_args[1]}',
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(),
    );
  }
}
