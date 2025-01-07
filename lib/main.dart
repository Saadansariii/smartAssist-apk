import 'package:flutter/material.dart';
import 'package:smart_assist/pages/login/home_screen.dart';
import 'package:smart_assist/pages/login/second_screen.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/pages/login/verify_mail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SetPwd(),
      theme: ThemeData(
        buttonTheme: ButtonThemeData(),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontSize: 29,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
      ),
      debugShowCheckedModeBanner: false,
      
    );
  }
}
