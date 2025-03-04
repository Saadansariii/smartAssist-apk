import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/pages/login/first_screen.dart';
import 'package:smart_assist/services/leads_srv.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:smart_assist/services/notifacation_srv.dart';
import 'package:smart_assist/utils/bottom_navigation.dart';
import 'package:smart_assist/utils/snackbar_helper.dart';
import 'package:smart_assist/utils/style_text.dart';
import 'package:smart_assist/utils/token_manager.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  final String email;
  final Function()? onLoginSuccess;
  const LoginPage({
    super.key,
    required this.email,
    required this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPwdController = TextEditingController();
  bool _isPasswordObscured = true;
  bool isLoading = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Slide animation from left (-1.5) to center (0)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.5, 0), // Start from left
      end: Offset.zero, // Move to center
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    newEmailController.dispose();
    newPwdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Stack(
            children: [
              // Main content - always visible
              Center(
                child: SingleChildScrollView(
                  // keyboardDismissBehavior:
                  //     ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image with animation applied
                        Hero(
                          tag: 'logo',
                          child: SlideTransition(
                              position: _slideAnimation,
                              child: SvgPicture.asset(
                                  'assets/logo-black.svg', // ✅ Correct way to load SVG
                                  // width: 120,
                                  width:
                                      MediaQuery.of(context).size.width * .3)),
                        ),
                        const SizedBox(height: 20),
                        const StyleText('Login to Smart Assist'),

                        // Only show the form after animation starts
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _controller.value,
                              child: child,
                            );
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 32),
                              buildInputLabel('Email'),
                              buildTextField(
                                newEmailController,
                                'Enter Email ID',
                                false,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 25),
                              buildInputLabel('Password'),
                              buildTextField(
                                  newPwdController, 'Enter Password', true),
                              const SizedBox(height: 32),
                              buildLoginButton(),
                              const SizedBox(height: 20),
                              buildRichText(
                                "Forgot Password ? ",
                                "Reset Password",
                                () {
                                  // TODO: Implement forgot password functionality
                                },
                              ),
                              const SizedBox(height: 16),
                              buildRichText(
                                "First time logging in ? ",
                                "Verify your e-mail",
                                () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const EmailSetupScreen(
                                        text: '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Loading Overlay (if needed, can be triggered later during login)
              // if (isLoading)
              //   Container(
              //     color: Colors.black.withOpacity(0.5),
              //     child: const Center(
              //       child: CircularProgressIndicator(
              //         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget for Login Button
  Widget buildLoginButton() {
    return ElevatedButton(
      // onPressed: isLoading ? null : submitBtn,
      onPressed: isLoading
          ? null
          : () {
              FocusScope.of(context).unfocus(); // Dismiss the keyboard
              submitBtn(); // Call the login function
            },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.colorsBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        // elevation: 4,
        // shadowColor: AppColors.colorsBlue.withOpacity(0.4),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: isLoading
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Login',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  // Widget for Input Labels
  Widget buildInputLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(4, 0, 0, 10),
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.fontColor,
          ),
        ),
      ),
    );
  }

  // Widget for TextFields
  Widget buildTextField(
    TextEditingController controller,
    String hint,
    bool isPassword, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      controller: controller,
      obscureText: isPassword ? _isPasswordObscured : false,
      keyboardType: keyboardType,
      textInputAction: isPassword ? TextInputAction.done : TextInputAction.next,
      decoration: InputDecoration(
        fillColor: const Color(0xffF3F9FF),
        filled: true,
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.hintTextColor,
          fontSize: 13,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordObscured
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: AppColors.fontColor,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordObscured = !_isPasswordObscured;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.colorsBlue, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  // Widget for RichText Links
  Widget buildRichText(String text, String linkText, VoidCallback onTap) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: AppColors.fontColor,
        ),
        children: [
          TextSpan(
            text: linkText,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.colorsBlue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }

  Future<void> submitBtn() async {
    if (!mounted) return;

    final email = newEmailController.text.trim();
    final pwd = newPwdController.text.trim();

    if (email.isEmpty || pwd.isEmpty) {
      showErrorMessage(context, message: 'Email and Password cannot be empty.');
      return;
    }

    setState(() => isLoading = true);

    try {
      final deviceToken = await FirebaseMessaging.instance.getToken();
      if (deviceToken == null) {
        throw Exception('Failed to retrieve device token.');
      }

      final response = await LeadsSrv.onLogin({
        "email": email,
        "password": pwd,
        "device_token": deviceToken,
      });

      if (!mounted) return;

      if (response['isSuccess'] == true && response['user'] != null) {
        final user = response['user'];
        final userId = user['user_id'];
        final authToken = response['token'];

        if (userId != null && authToken != null) {
          // Save authentication data
          await TokenManager.saveAuthData(authToken, userId);

          // Initialize FCM after successful login
          await NotificationService.instance.initialize();

          showSuccessMessage(context, message: 'Login Successful!');
          Get.offAll(() => BottomNavigation());

          widget.onLoginSuccess?.call();
        } else {
          throw Exception('Invalid user data or token received');
        }
      } else {
        // Throw an exception with the error message from the backend
        throw Exception(response['message'] ?? 'Login failed: Unknown error');
      }
    } catch (error) {
      if (!mounted) return;
      showErrorMessage(context, message: error.toString());
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }
}
