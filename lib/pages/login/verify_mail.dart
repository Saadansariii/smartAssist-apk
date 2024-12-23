import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_assist/pages/button.dart';
import 'package:smart_assist/pages/style_text.dart';

class VerifyMail extends StatefulWidget {
  const VerifyMail({super.key});

  @override
  State<VerifyMail> createState() => _SetPwdState();
}

class _SetPwdState extends State<VerifyMail> {
   

  // Form key for validation );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      resizeToAvoidBottomInset: true, // Prevents bottom overflow
      appBar: AppBar(),
      body: SafeArea(
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
                    'assets/lock.png',
                    width: 250,
                  ),

                  // Title
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: StyleText('Verify Your Email address'),
                  ),

                  // Subtitle
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.grey), // Default text color
                        children: [
                          const TextSpan(
                            text: 'An 6-digit code has been sent to ',
                            style: TextStyle(fontSize: 16 , height: 2),
                          ),
                          const TextSpan(
                            text: 'Richard@gmail.com',
                            style: TextStyle(
                                color:
                                    Colors.black), // Dark color for the email
                          ),
                          TextSpan(
                            text: ' Change',
                            style: const TextStyle(
                              color: Colors.blue, // Link-like color
                              decoration: TextDecoration
                                  .underline, // Underline the "Change" text
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Handle the "Change" tap event here
                                // print("Change clicked");
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "Didn't receive the code? ", // Text before the link
                        style: const TextStyle(
                            color: Colors
                                .grey , fontSize: 16), // Default style for the first part
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration
                                  .underline, // Underline the link
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // print('Resend clicked');
                              },
                          ),
                        ],
                      ),
                    ),
                  ), // Next Step Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 26 ,  horizontal: 8),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/home'); // Navigate to Page Two
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0276FE),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Button('Verify'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
