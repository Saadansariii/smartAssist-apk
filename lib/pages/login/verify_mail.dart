import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/pages/login/second_screen.dart';
import 'package:smart_assist/services/otp_srv.dart';
import 'package:smart_assist/utils/button.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';

class VerifyMail extends StatefulWidget {
  final int _otpLength = 6; // Number of OTP digits
  final List<TextEditingController> _controllers =
      List.generate(6, (index) => TextEditingController());

  final String email;
  VerifyMail({super.key, required this.email});

  @override
  State<VerifyMail> createState() => _SetPwdState();
}

class _SetPwdState extends State<VerifyMail> {
  // Form key for validation );
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
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
                                          builder: (context) =>
                                              const SetPwd()));
                                },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // TextField(
                    //   controller: otpController,
                    //   decoration: const InputDecoration(hintText: 'Enter otp'),
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget._otpLength, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          width: 45,
                          child: TextField(
                            controller: widget._controllers[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty &&
                                  index < widget._otpLength - 1) {
                                FocusScope.of(context).nextFocus();
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context).previousFocus();
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
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
                    ), // Next Step Button
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 26, horizontal: 8),
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
      ),
    );
  }

  Future<void> onVerify() async {
    // Combine all the text from the individual controllers to form the OTP as a string
    final otpString =
        widget._controllers.map((controller) => controller.text).join();

    // Ensure the OTP is valid (numeric and correct length)
    if (otpString.length != widget._otpLength ||
        int.tryParse(otpString) == null) {
      showErrorMessage(context,
          message: 'Invalid OTP. Please enter a valid code.');
      return;
    }

    // Convert the OTP string to an integer for the API
    final otp = int.parse(otpString);

    final body = {"otp": otp, "email": widget.email};

    try {
      final response = await OtpSrv.verifyEmail(body);

      print('API Response: $response');

      if (response['isSuccess'] == true) {
        showSuccessMessage(context, message: 'Email Verified Successfully');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetNewPwd(email: widget.email),
          ),
        );
      } else {
        showErrorMessage(context, message: 'Check the Email or OTP');
      }
    } catch (error) {
      showErrorMessage(context, message: 'Error during API call');
    }
  }
}
