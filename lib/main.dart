import 'package:flutter/material.dart';
import 'package:smart_assist/pages/login/home_screen.dart';
import 'package:smart_assist/pages/login/set_new_pwd.dart';
import 'package:smart_assist/pages/login/set_pwd.dart';
import 'package:smart_assist/pages/login/verify_mail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Color(0xFF1380FE), 
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/setPassword',
      routes: {
        '/setPassword': (context) => const SetPwd(),
        '/setNewPassword': (context) => const SetNewPwd(),
        '/verifyEmail': (context) => const VerifyMail(),
        '/home': (context) => const HomeScreen()
      },
    );
  }
}
