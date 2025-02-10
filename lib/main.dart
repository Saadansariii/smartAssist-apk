// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:get/get.dart'; 
// import 'package:smart_assist/pages/login/login_page.dart';
// import 'package:hive_flutter/hive_flutter.dart'; 
// import 'package:smart_assist/services/notifacation_srv.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart'; 

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp();
//     print("Firebase initialized successfully!");
//   } catch (e) {
//     print("Firebase initialization failed: $e");
//   }

//   await Hive.initFlutter(); // Initialize Hive after Firebase
//   await NotificationService.instance.initialize(); // Initialize Notifications

//   runApp(ProviderScope(child: const MyApp()));
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       // home: LoginPage(
//       //   email: '',
//       // ),
//       // home: BottomNavigation(),
//       home: LoginPage(
//         onLoginSuccess: () {
//           Get.off(() => BottomNavigation());
//         },
//         email: '',
//       ),
//       theme: ThemeData(
//         buttonTheme: const ButtonThemeData(),
//         textTheme: const TextTheme(
//             titleLarge: TextStyle(
//               fontSize: 29,
//               fontWeight: FontWeight.bold,
//             ),
//             titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
//             titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//         scaffoldBackgroundColor: const Color(0xFFFFFFFF),
//         appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
//       ),

//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:smart_assist/services/notifacation_srv.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print("✅ Firebase initialized successfully!");
  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }

  await Hive.initFlutter(); // Initialize Hive
  await NotificationService.instance.initialize(); // Initialize Notifications

  // Determine the initial route
  Widget initialScreen = await getInitialScreen();

  runApp(ProviderScope(child: MyApp(initialScreen: initialScreen)));
}

Future<Widget> getInitialScreen() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');

  if (token != null) {
    return BottomNavigation(); // User is logged in, show home screen
  } else {
    return LoginPage(
      onLoginSuccess: () {
        Get.off(() => BottomNavigation());
      },
      email: '',
    ); // User is not logged in, show login page
  }
}

class MyApp extends StatelessWidget {
  final Widget initialScreen;
  const MyApp({super.key, required this.initialScreen});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: initialScreen, // Set dynamic initial screen
      theme: ThemeData(
        buttonTheme: const ButtonThemeData(),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 29,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
