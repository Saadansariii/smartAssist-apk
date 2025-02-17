// notification work here

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:smart_assist/config/route/route.dart';
import 'package:smart_assist/config/route/route_name.dart'; 
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_assist/pages/login/splash_screen.dart'; 
import 'package:smart_assist/services/notifacation_srv.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully!");
  } catch (e) {
    print("Firebase initialization failed: $e");
  }

  await Hive.initFlutter(); // Initialize Hive after Firebase
  await NotificationService.instance.initialize(); // Initialize Notifications

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute ,

      // home: SplashScreen(),
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
      ),

      debugShowCheckedModeBanner: false,
    );
  }
}






































// notification also have some error work here
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:smart_assist/pages/login/login_page.dart';
// import 'package:smart_assist/utils/app_initializer.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart'; 

// Future<Widget> getInitialScreen() async {
//   try {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('auth_token');

//     // Only check if token exists, not if it's valid
//     if (token != null) {
//       return BottomNavigation();
//     } else {
//       return LoginPage(
//         onLoginSuccess: () {
//           Get.offAll(() => BottomNavigation());
//         },
//         email: '',
//       );
//     }
//   } catch (e) {
//     print("❌ Error determining initial screen: $e");
//     return LoginPage(
//       onLoginSuccess: () {
//         Get.offAll(() => BottomNavigation());
//       },
//       email: '',
//     );
//   }
// }

// void main() async {
//   try {
//     await AppInitializer.initialize();
//     Widget initialScreen = await getInitialScreen();

//     runApp(
//       ProviderScope(
//         child: MyApp(initialScreen: initialScreen),
//       ),
//     );
//   } catch (e) {
//     print("❌ Fatal error during app initialization: $e");
//     runApp(
//       GetMaterialApp(
//         home: LoginPage(
//           onLoginSuccess: () {
//             Get.offAll(() => BottomNavigation());
//           },
//           email: '',
//         ),
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }
// class MyApp extends StatelessWidget {
//   final Widget initialScreen;
//   const MyApp({super.key, required this.initialScreen});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: initialScreen, // Set dynamic initial screen
//       debugShowMaterialGrid: false,
//       theme: ThemeData(
//         buttonTheme: const ButtonThemeData(),
//         textTheme: const TextTheme(
//           titleLarge: TextStyle(
//             fontSize: 29,
//             fontWeight: FontWeight.bold,
//           ),
//           titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
//           titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//         ),
//         scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//         appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
//       ),
//     );
//   }
// }
