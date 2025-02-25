// import 'package:flutter/material.dart';

// class AppFont {

// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFont {
  static TextStyle dropDown({
    double fontSize = 14,
    Color color = Colors.grey,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle dropDowmLabel({
    double fontSize = 14,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bold({
    double fontSize = 14,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle popupTitle({
    double fontSize = 20,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle buttons({
    double fontSize = 16,
    Color color = Colors.white,
  }) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
  }

  static TextStyle appbarfontWhite({
    double fontSize = 18,
    Color color = Colors.white,
  }) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
  }

   static TextStyle appbarfontgrey({
    double fontSize = 18,
    Color color = const Color(0xff767676),
  }) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
  }
}
