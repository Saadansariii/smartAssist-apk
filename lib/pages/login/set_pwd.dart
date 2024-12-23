import 'package:flutter/material.dart';
import 'package:smart_assist/pages/button.dart';
import 'package:smart_assist/pages/paragraph_text.dart';
import 'package:smart_assist/pages/style_text.dart';

class SetPwd extends StatefulWidget {
  const SetPwd({super.key});

  @override
  State<SetPwd> createState() => _SetPwdState();
}

class _SetPwdState extends State<SetPwd> {
  // Controllers for text fields
  final TextEditingController _passwordController = TextEditingController();

  // Password visibility toggle
  bool _isPasswordObscured = true;

  // Form key for validation );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

                  const Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(6, 20, 0, 0),
                          child: Text('Email'))
                    ],
                  ),
                  // Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isPasswordObscured,
                      decoration: InputDecoration(
                        hintText: 'Enter Email ID',
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordObscured
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isPasswordObscured = !_isPasswordObscured;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  // Next Step Button
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      onPressed: () {
                         // ignore: avoid_print
                         print('navigate to setnewpwd');
                        Navigator.pushNamed(
                            context, '/setNewPassword'); // Navigate to Page Two
                      },
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
    );
  }
}
