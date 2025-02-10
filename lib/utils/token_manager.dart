import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';  

class TokenManager {
  static const String TOKEN_KEY = 'auth_token';
  static const String USER_ID_KEY = 'user_id';

  // Check token validity
  static Future<bool> isTokenValid() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString(TOKEN_KEY);

      if (token == null) return false;

      // Decode and check token expiration
      bool isExpired = JwtDecoder.isExpired(token);
      return !isExpired;
    } catch (e) {
      print('Error checking token validity: $e');
      return false;
    }
  }

  // Save token and user data
  static Future<void> saveAuthData(String token, String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(TOKEN_KEY, token);
    await prefs.setString(USER_ID_KEY, userId);
  }

  // Clear auth data
  static Future<void> clearAuthData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(TOKEN_KEY);
    await prefs.remove(USER_ID_KEY);
  }

  // Logout and redirect to login
  static Future<void> logout(BuildContext context) async {
    await clearAuthData();
    Get.offAll(() => LoginPage(
          email: '',
          onLoginSuccess: () {},
        ));
  }
}

// Authentication middleware
class AuthMiddleware extends GetMiddleware {
  @override
  Future<GetNavConfig?> redirectDelegate(GetNavConfig route) async {
    if (!await TokenManager.isTokenValid()) {
      return GetNavConfig.fromRoute('/login');
    }
    return await super.redirectDelegate(route);
  }
}

 
