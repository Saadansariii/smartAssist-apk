import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/services/otp_srv.dart';
import 'package:smart_assist/utils/button.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';

class VerifyMail extends StatefulWidget {
  final String email;
  const VerifyMail({super.key, required this.email});

  @override
  State<VerifyMail> createState() => _SetPwdState();
}

class _SetPwdState extends State<VerifyMail> {
  // Form key for validation );
  final TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
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
                            style: TextStyle(fontSize: 16, height: 2),
                          ),
                          TextSpan(
                            text: '${widget.email}',
                            style: const TextStyle(
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SetPwd()));
                              },
                          ),
                        ],
                      ),
                    ),
                  ),

                  TextField(
                    controller: otpController,
                    decoration: const InputDecoration(hintText: 'Enter otp'),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 100, 0, 0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "Didn't receive the code? ", // Text before the link
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16), // Default style for the first part
                        children: [
                          TextSpan(
                            text: 'Resend',
                            style: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration
                                  .underline, // Underline the link
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ), // Next Step Button
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 26, horizontal: 8),
                    child: ElevatedButton(
                      onPressed: onVerify,
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

  Future<void> onVerify() async {
    final otp = otpController.text;
    final email = emailController.text; // Retrieve email from the controller
    final body = {"otp": otp, "email": email};

    try {
      final response = await OtpSrv.verifyEmail(body);

      if (response['isSuccess'] == true) {
        print('API hit successful: ${response['data']}');
        showSuccessMessage(context, message: 'Email Verified Successfully');

        // Navigate to VerifyMail screen with the email
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyMail(email: email),
          ),
        );
      } else {
        print('API hit failed: ${response['data']}');
        showErrorMessage(context, message: 'Check the Email');
      }
    } catch (error) {
      // Handle unexpected errors
      print('Unexpected error: $error');
      showErrorMessage(context, message: 'Error during API call');
    }
  }
}
