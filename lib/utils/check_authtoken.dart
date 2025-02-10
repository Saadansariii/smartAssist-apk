import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/pages/login/login_page.dart';

Future<void> checkTokenValidity(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('auth_token');

  if (token == null || await isTokenExpired(token)) {
    // Token is invalid, log the user out
    logoutUser(context);
  }
}

Future<bool> isTokenExpired(String token) async {
  // Simulating token expiration check; Modify as needed
  // Decode token or check expiration API
  return false; // Replace this with real expiry check
}

void logoutUser(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('auth_token'); // Remove token
  await prefs.remove('user_id'); // Remove user ID

  Get.offAll(() => LoginPage(email: '', onLoginSuccess: () {  },)); // Redirect to login
}
