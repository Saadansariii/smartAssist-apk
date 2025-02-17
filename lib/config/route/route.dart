import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_assist/config/route/route_name.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:smart_assist/pages/login/splash_screen.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splashScreen:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case RoutesName.login:
        return MaterialPageRoute(
          builder: (context) => LoginPage(
            onLoginSuccess: () {
              Get.off(() => BottomNavigation());
            },
            email: '',
          ),
        );
      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (context) => const ());
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('no route matched'),
            ),
          ),
        );
    }
  }
}
