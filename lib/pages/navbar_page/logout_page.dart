import 'package:flutter/material.dart';
import 'package:smart_assist/pages/home_screens/home_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/pages/login/login_page.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffEEEEF2),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Container(
          width: 300, // Constrains the width of the content
          child: Column(
            mainAxisSize: MainAxisSize.min, // Centers content vertically
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Logout',
                style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Text(
                'Are you sure you want to logout ?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 202, 200, 200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(
                                  email: '',
                                ),
                              ));
                        },
                        child: Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
