import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_assist/pages/details_pages/followups/followups.dart';
import 'package:smart_assist/pages/home_screens/single_id_screens/single_leads.dart';
// import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_assist/pages/notification/notification.dart';
import 'package:smart_assist/services/notifacation_srv.dart';
// import 'package:smart_assist/pages/details_pages/test_drive_details.dart';
// import 'package:smart_assist/pages/home_screen.dart';
// import 'package:smart_assist/pages/login/first_screen.dart';
// import 'package:smart_assist/pages/login/verify_mail.dart';
// import 'package:smart_assist/pages/navbar_page/favorite.dart';

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
    return MaterialApp(
      home: LoginPage(
        email: '',
      ),
      // home: FollowupsDetails(),
      // home: NotificationPage(),
      // home: (),
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
