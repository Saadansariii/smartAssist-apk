// notification work here

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:smart_assist/config/route/route.dart';
import 'package:smart_assist/config/route/route_name.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RoutesName.splashScreen,
      onGenerateRoute: Routes.generateRoute,

      // home: BottomNavigation(),
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
