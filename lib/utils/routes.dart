import 'package:barberbla/pages/signup.dart';
import 'package:barberbla/utils/root.dart';
import 'package:get/get.dart';

routes() => [
      GetPage(name: '/', page: () => Root()),
      GetPage(name: '/signup', page: () => Signup()),
      // GetPage(name: '/dashboard', page: () => DashboardPage()),
    ];
