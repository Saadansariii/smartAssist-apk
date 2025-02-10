import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smart_assist/services/notifacation_srv.dart';

class AppInitializer {
  static Future<void> initialize() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      await Future.wait([
        _initializeFirebase(),
        _initializeHive(),
        NotificationService.instance.initialize(),
      ]);

      print("✅ All services initialized successfully!");
    } catch (e) {
      print("❌ Initialization error: $e");
      rethrow;
    }
  }

  static Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print("✅ Firebase initialized successfully!");
    } catch (e) {
      print("❌ Firebase initialization failed: $e");
      rethrow;
    }
  }

  static Future<void> _initializeHive() async {
    try {
      await Hive.initFlutter();
      print("✅ Hive initialized successfully!");
    } catch (e) {
      print("❌ Hive initialization failed: $e");
      rethrow;
    }
  }
}
