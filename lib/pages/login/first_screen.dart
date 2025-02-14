import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/login/second_screen.dart';
import 'package:smart_assist/services/email_srv.dart';
import 'package:smart_assist/utils/button.dart';
import 'package:smart_assist/utils/paragraph_text.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';

class SetPwd extends StatefulWidget {
  const SetPwd({super.key});

  @override
  State<SetPwd> createState() => _SetPwdState();
}

class _SetPwdState extends State<SetPwd> {
  // Controllers for text fields
  // final TextEditingController _passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      child: StyleText('Set Your Email'),
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
                    //         padding: EdgeInsets.fromLTRB(6, 20, 0, 0),
                    //         child: Text('Email'))
                    //   ],
                    // ),
                    // // Password TextField
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 10),
                    //   child: TextFormField(
                    //     controller: emailController,
                    //     decoration: InputDecoration(
                    //       hintText: 'Enter Email ID',
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
                          'Email',
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
                      style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                      // controller: _passwordController,
                      controller: emailController,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF3F9FF),
                        filled: true,
                        hintText: 'Enter Email ID', // Only placeholder text
                        // fillColor: Colors.grey,
                        hintStyle: TextStyle(color: Colors.grey),
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
                        onPressed: verifyEmail,
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

  Future<void> verifyEmail() async {
    final email = emailController.text;
    final body = {"email": email};

    try {
      final response = await EmailService.verifyEmail(body);

      if (response['isSuccess'] == true) {
        print('API hit successful: ${response['data']}');
        showSuccessMessage(context, message: 'Email Verified Successfully');

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyMail(email: emailController.text),
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
