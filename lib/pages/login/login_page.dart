import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/services/login_srv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final String email;
  final Function() onLoginSuccess;
  const LoginPage(
      {super.key, required this.email, required this.onLoginSuccess});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();
  bool _isPasswordObscured = true;
  bool isLoading = false; // Controls the loading state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          children: [
            // Main UI
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/loginbro.png',
                        width: 250,
                      ),
                      StyleText('Login to Smart Assist'),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Email',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextField(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        controller: newEmailController,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F9FF),
                          filled: true,
                          hintText: 'Enter Email ID',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Row(
                        children: [
                          Text(
                            'Password',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      TextField(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        controller: newPwdController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          fillColor: Color(0xffF3F9FF),
                          filled: true,
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordObscured
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: ElevatedButton(
                          onPressed: submitBtn,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0276FE),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      ),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Forgot Password ? ", // Text before the link
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ), // Default style for the first part
                          children: [
                            TextSpan(
                              text: 'Reset Password',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ), // Next Step Button
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "First time logging in ? ", // Text before the link
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ), // Default style for the first part
                          children: [
                            TextSpan(
                              text: 'Verify your e-mail',
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SetPwd()));
                                },
                            ),
                          ],
                        ),
                      ), // Next Step Button
                    ],
                  ),
                ),
              ),
            ),

            // Loading Overlay
            if (isLoading)
              Container(
                color: Colors.white
                    .withOpacity(0.8), // Semi-transparent white background
                child: Center(
                  child: CircularProgressIndicator(), // Spinner
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Future<void> submitBtn() async {
  //   final email = newEmailController.text.trim();
  //   final pwd = newPwdController.text.trim();

  //   if (email.isEmpty || pwd.isEmpty) {
  //     showErrorMessage(context, message: 'Email and Password cannot be empty.');
  //     return;
  //   }

  //   final deviceToken = await FirebaseMessaging.instance.getToken();

  //   if (deviceToken == null) {
  //     showErrorMessage(context, message: 'Failed to retrieve device token.');
  //     return;
  //   }

  //   final body = {
  //     "email": email,
  //     "password": pwd,
  //     "device_token": deviceToken,
  //   };

  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     final response = await LoginSrv.onLogin(body);
  //     print('Full API Response: $response'); // Debugging

  //     if (response['isSuccess'] == true && response.containsKey('user')) {
  //       final user = response['user'];

  //       if (user.containsKey('user_id')) {
  //         final userId = user['user_id'];
  //         print('User ID received: $userId');

  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('user_id', userId);

  //         // showSuccessMessage(context, message: 'Login Successful!');
  //         Get.offAll(() => BottomNavigation());
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute(builder: (context) => HomeScreen()),
  //         );
  //       } else {
  //         print('Error: user_id not found inside user object.');
  //         showErrorMessage(context, message: 'User ID not found.');
  //       }
  //     } else {
  //       print('Error: User data missing or API call failed.');
  //       showErrorMessage(context, message: 'Login failed.');
  //     }
  //   } catch (error) {
  //     print('Error during API call: $error');
  //     showErrorMessage(context, message: 'Error during API call: $error');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }


// work fine

  // Future<void> submitBtn() async {
  //   final email = newEmailController.text.trim();
  //   final pwd = newPwdController.text.trim();

  //   if (email.isEmpty || pwd.isEmpty) {
  //     showErrorMessage(context, message: 'Email and Password cannot be empty.');
  //     return;
  //   }

  //   final deviceToken = await FirebaseMessaging.instance.getToken();
  //   if (deviceToken == null) {
  //     showErrorMessage(context, message: 'Failed to retrieve device token.');
  //     return;
  //   }

  //   final body = {
  //     "email": email,
  //     "password": pwd,
  //     "device_token": deviceToken,
  //   };

  //   setState(() {
  //     isLoading = true;
  //   });

  //   try {
  //     final response = await LoginSrv.onLogin(body);
  //     print('Full API Response: $response'); // Debugging

  //     if (response['isSuccess'] == true && response.containsKey('user')) {
  //       final user = response['user'];

  //       if (user.containsKey('user_id')) {
  //         final userId = user['user_id'];
  //         print('User ID received: $userId');

  //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //         await prefs.setString('user_id', userId);

  //         showSuccessMessage(context, message: 'Login Successful!');
  //         Get.offAll(() => BottomNavigation());  
  //       } else {
  //         print('Error: user_id not found inside user object.');
  //         showErrorMessage(context, message: 'User ID not found.');
  //       }
  //     } else {
  //       print('Error: User data missing or API call failed.');
  //       showErrorMessage(context, message: 'Login failed.');
  //     }
  //   } catch (error) {
  //     print('Error during API call: $error');
  //     showErrorMessage(context, message: 'Error during API call: $error');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

Future<void> submitBtn() async {
    final email = newEmailController.text.trim();
    final pwd = newPwdController.text.trim();

    if (email.isEmpty || pwd.isEmpty) {
      showErrorMessage(context, message: 'Email and Password cannot be empty.');
      return;
    }

    final deviceToken = await FirebaseMessaging.instance.getToken();
    if (deviceToken == null) {
      showErrorMessage(context, message: 'Failed to retrieve device token.');
      return;
    }

    final body = {
      "email": email,
      "password": pwd,
      "device_token": deviceToken,
    };

    setState(() {
      isLoading = true;
    });

    try {
      final response = await LoginSrv.onLogin(body);
      print('Full API Response: $response');

      if (response['isSuccess'] == true && response.containsKey('user')) {
        final user = response['user'];

        if (user.containsKey('user_id') && response.containsKey('token')) {
          final userId = user['user_id'];
          final authToken = response['token']; // Assuming API returns a token

          print('User ID received: $userId');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_id', userId);
          await prefs.setString('auth_token', authToken); // Save auth token

          showSuccessMessage(context, message: 'Login Successful!');
          Get.offAll(() => BottomNavigation()); // Navigate to home
        } else {
          print('Error: User ID or token not found.');
          showErrorMessage(context, message: 'Login failed.');
        }
      } else {
        print('Error: User data missing or API call failed.');
        showErrorMessage(context, message: 'Login failed.');
      }
    } catch (error) {
      print('Error during API call: $error');
      showErrorMessage(context, message: 'Error during API call: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

}
