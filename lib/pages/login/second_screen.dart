import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:smart_assist/services/set_pwd_srv.dart';
import 'package:smart_assist/utils/button.dart';
import 'package:smart_assist/utils/paragraph_text.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SetNewPwd extends StatefulWidget {
  final String email;
  const SetNewPwd({super.key, required this.email});

  @override
  State<SetNewPwd> createState() => _SetPwdState();
}

class _SetPwdState extends State<SetNewPwd> {
  final TextEditingController newPwdController = TextEditingController();
  final TextEditingController confirmPwdController = TextEditingController();
  // Controllers for text fields
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();

  // Password visibility toggle
  bool _isPasswordObscured1 = true;
  bool _isPasswordObscured2 = true;

  // Form key for validation );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Prevents bottom overflow

      body: Center(
        child: SafeArea(
          // Adds safe area to prevent bottom inset issues
          child: SingleChildScrollView(
            // Allows scrolling when keyboard appears
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image
                    Image.asset(
                      'assets/loginbro.png',
                      width: 250,
                    ),

                    // Title
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: StyleText('Set Your Password'),
                    ),

                    // Subtitle
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: ParagraphText(
                        'In order to keep your account safe, you need to create a strong password.',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),

                    // const Row(
                    //   children: [
                    //     Padding(
                    //         padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                    //         child: Text('Password'))
                    //   ],
                    // ),
                    // // Password TextField
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: TextField(
                    //     // controller: _passwordController,
                    //     controller: newPwdController,
                    //     obscureText: _isPasswordObscured,
                    //     decoration: InputDecoration(
                    //       hintText:
                    //           'Enter your password', // Only placeholder text
                    //       fillColor: Colors.grey,
                    //       suffixIcon: IconButton(
                    //         icon: Icon(
                    //           _isPasswordObscured
                    //               ? Icons.visibility_off
                    //               : Icons.visibility,
                    //         ),
                    //         onPressed: () {
                    //           setState(() {
                    //             _isPasswordObscured = !_isPasswordObscured;
                    //           });
                    //         },
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    Row(
                      children: [
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Password TextField
                    TextField(
                      obscureText: _isPasswordObscured1,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      // controller: _passwordController,
                      controller: newPwdController,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF3F9FF),
                        filled: true,
                        hintText: 'Password', // Only placeholder text
                        hintStyle: TextStyle(color: Colors.grey),
                        // fillColor: Colors.grey,
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordObscured1
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured1 = !_isPasswordObscured1;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // const Row(
                    //   children: [
                    //     Padding(
                    //         padding: EdgeInsets.fromLTRB(6, 0, 0, 0),
                    //         child: Text('Confirm Password'))
                    //   ],
                    // ),

                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: TextFormField(
                    //     controller: confirmPwdController,
                    //     obscureText: _isPasswordObscured,
                    //     decoration: InputDecoration(
                    //       hintText: 'Enter Confirm Password',
                    //       suffixIcon: IconButton(
                    //         icon: Icon(_isPasswordObscured
                    //             ? Icons.visibility_off
                    //             : Icons.visibility),
                    //         onPressed: () {
                    //           setState(() {
                    //             _isPasswordObscured = !_isPasswordObscured;
                    //           });
                    //         },
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 5,
                          width: 5,
                        ),
                        Text(
                          'Confirm Password',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    // Password TextField
                    TextField(
                      obscureText: _isPasswordObscured2,
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      controller: confirmPwdController,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF3F9FF),
                        filled: true,
                        hintText: 'Confirm Password', // Only placeholder text
                        hintStyle: TextStyle(color: Colors.grey),
                        // fillColor: Colors.grey,
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordObscured2
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured2 = !_isPasswordObscured2;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    // Next Step Button
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
                        child: const Button('Next Step'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submitBtn() async {
    final newPwd = newPwdController.text.trim();
    final confirmPwd = confirmPwdController.text.trim();

    // Check if fields are empty
    if (newPwd.isEmpty || confirmPwd.isEmpty) {
      showErrorMessage(context, message: 'Please fill in all fields');
      return;
    }

    // Optional: Add further validation, like password length or matching passwords
    if (newPwd != confirmPwd) {
      showErrorMessage(context, message: 'Passwords do not match');
      return;
    }

    final deviceToken = await FirebaseMessaging.instance.getToken();

    // Check if the token is available
    if (deviceToken == null) {
      print('Failed to retrieve device token');
      return;
    }

    // Prepare the body with email, new password, confirm password, and device token
    final body = {
      "email": widget.email,
      "newPwd": newPwd,
      "confirmPwd": confirmPwd,
      "device_token": deviceToken,
    };

    try {
      final response = await SetPwdSrv.SetPwd(body);

      print('API Response: $response');

      if (response['isSuccess'] == true) {
        showSuccessMessage(context, message: 'Email Verified Successfully');

        // Navigate to LoginPage
        Navigator.push(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else {
        showErrorMessage(context, message: 'Check the Email or OTP');
      }
    } catch (error) {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, message: 'Error during API call');
    }
  }
}
