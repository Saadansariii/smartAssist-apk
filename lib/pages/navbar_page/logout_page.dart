// import 'package:flutter/material.dart';
// import 'package:smart_assist/pages/home_screens/home_screen.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/pages/login/login_page.dart';
// import 'package:smart_assist/utils/bottom_navigation.dart';

// class LogoutPage extends StatelessWidget {
//   const LogoutPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffEEEEF2),
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => BottomNavigation(),
//               ),
//             );
//           },
//           icon: const Icon(
//             FontAwesomeIcons.angleLeft,
//             color: Colors.white,
//           ),
//         ),
//         title: Text(
//           'Logout',
//           style: GoogleFonts.poppins(
//             fontSize: 18,
//             fontWeight: FontWeight.w400,
//             color: Colors.white,
//           ),
//         ),
//         backgroundColor: Colors.blue,
//         automaticallyImplyLeading: false,
//       ),
//       body: Center(
//         child: Container(
//           width: 300, // Constrains the width of the content
//           child: Column(
//             mainAxisSize: MainAxisSize.min, // Centers content vertically
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 'Logout',
//                 style: GoogleFonts.poppins(
//                     fontSize: 24,
//                     color: Colors.blue,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(height: 20),
//               Text(
//                 'Are you sure you want to logout ?',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                     fontSize: 14,
//                     color: const Color.fromARGB(255, 115, 115, 115),
//                     fontWeight: FontWeight.w300),
//               ),
//               SizedBox(height: 30),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 202, 200, 200),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => BottomNavigation()));
//                         },
//                         child: Text(
//                           'Cancel',
//                           style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   Expanded(
//                     child: Container(
//                       height: 45,
//                       decoration: BoxDecoration(
//                         color: Colors.blue,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: TextButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginPage(
//                                   email: '',
//                                   onLoginSuccess: () {},
//                                 ),
//                               ));
//                         },
//                         child: Text(
//                           'Logout',
//                           style: GoogleFonts.poppins(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/color/colors.dart';
import 'package:smart_assist/config/component/font/font.dart';
import 'package:smart_assist/pages/login/login_page.dart';
import 'package:smart_assist/utils/bottom_navigation.dart'; 
import 'package:smart_assist/utils/token_manager.dart'; 
import 'package:get/get.dart';

class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  // Add a method to handle the logout process
  Future<void> _handleLogout(BuildContext context) async {
    try {
      // Clear the stored token and user data
      await TokenManager.clearAuthData();

      // Optionally unregister from FCM topics if needed
      // await NotificationService.instance.unregisterFromTopics();

      // Navigate to login and clear all previous routes
      Get.offAll(() => LoginPage(
            email: '',
            onLoginSuccess: () {},
          ));

      // Show success message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Logged out successfully')));
    } catch (error) {
      print('Logout error: $error');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error logging out: $error')));
    }
  }

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
                builder: (context) => BottomNavigation(),
              ),
            );
          },
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.white,
          ),
        ),
        title: Text('Logout', style: AppFont.appbarfontWhite()),
        backgroundColor: AppColors.colorsBlue,
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
                    color: AppColors.colorsBlue,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 20),
              Text(
                'Are you sure you want to logout ?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 115, 115, 115),
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 202, 200, 200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavigation()));
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
                        color: AppColors.colorsBlue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        // Changed to use the logout handler
                        onPressed: () => _handleLogout(context),
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
