import 'package:barberbla/pages/services_page.dart';
import 'package:barberbla/utils/root.dart';
import 'package:barberbla/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Barberbla',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Color.fromARGB(255, 77, 208, 225),
        inputDecorationTheme: ThemeData().inputDecorationTheme.copyWith(
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 77, 208, 225),
                ),
              ),
            ),
        textTheme: ThemeData().textTheme.copyWith(
            headline4: TextStyle(
              color: Colors.black.withOpacity(0.5),
            ),
            bodyText1: TextStyle(
              color: Colors.black.withOpacity(1),
            ),
            bodyText2: TextStyle(
              color: Colors.black.withOpacity(1),
            ),
            headline6: TextStyle(color: Colors.white),
            subtitle2: TextStyle(decoration: TextDecoration.underline)),
        fontFamily: 'Raleway',
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          primary: Color.fromARGB(255, 77, 208, 225),
        )),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Root(),
      // home: DashboardPage(),
      getPages: routes(),
      builder: EasyLoading.init(),
    );
  }
}
