import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/services/login_srv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';

class LoginPage extends StatefulWidget {
  final String email;
  const LoginPage({super.key, required this.email});

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
      isLoading = true; // Start loading
    });

    try {
      final response = await LoginSrv.onLogin(body);

      if (response['isSuccess'] == true) {
        showSuccessMessage(context, message: 'Login Successful!');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        final errorMessage = response['data']['message'] ?? 'Login failed.';
        showErrorMessage(context, message: errorMessage);
      }
    } catch (error) {
      showErrorMessage(context, message: 'Error during API call: $error');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }
}
