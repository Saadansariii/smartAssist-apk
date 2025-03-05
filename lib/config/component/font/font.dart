// // import 'package:flutter/material.dart';

// // class AppFont {

// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_launcher_icons/xml_templates.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:smart_assist/config/component/color/colors.dart';

// class AppFont {
//   static TextStyle dropDown({
//     double fontSize = 14,
//     Color color = Colors.grey,
//     FontWeight fontWeight = FontWeight.w500,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: fontWeight,
//     );
//   }

//   static TextStyle dropDowmLabel({
//     double fontSize = 14,
//     Color color = Colors.black,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.w500,
//     );
//   }

//   static TextStyle bold({
//     double fontSize = 14,
//     Color color = Colors.black,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.bold,
//     );
//   }

//   static TextStyle popupTitle({
//     double fontSize = 20,
//     Color color = AppColors.colorsBlue,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.w600,
//     );
//   }

//    static TextStyle popupTitleBlack({
//     double fontSize = 20,
//     Color color = AppColors.fontBlack,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.w600,
//     );
//   }

//   static TextStyle calanderDayName({
//     double fontSize = 12,
//     Color color = Colors.black,
//   }) {
//     return GoogleFonts.poppins(
//       fontSize: fontSize,
//       color: color,
//       fontWeight: FontWeight.w500,
//     );
//   }

//   static TextStyle buttons({
//     double fontSize = 16,
//     Color color = Colors.white,
//   }) {
//     return GoogleFonts.poppins(
//         fontSize: fontSize, color: color, fontWeight: FontWeight.w700);
//   }

//   static TextStyle appbarfontWhite({
//     double fontSize = 18,
//     Color color = Colors.white,
//   }) {
//     return GoogleFonts.poppins(
//         fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
//   }

//   static TextStyle appbarfontgrey({
//     double fontSize = 18,
//     Color color = const Color(0xff767676),
//   }) {
//     return GoogleFonts.poppins(
//         fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
//   }

//   static TextStyle searchFontTitle({
//     double fontSize = 12,
//     Color color = AppColors.fontBlack,
//   }) {
//     return GoogleFonts.poppins(
//         fontSize: fontSize, color: color, fontWeight: FontWeight.w500);
//   }

//   static TextStyle searchFontSubtitle({
//     double fontSize = 12,
//     Color color = const Color(0xff767676),
//   }) {
//     return GoogleFonts.poppins(
//         fontSize: fontSize, color: color, fontWeight: FontWeight.w400);
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_assist/config/component/color/colors.dart';

class AppFont {
  // ✅ Utility function to scale font dynamically based on device type
  static double scaleFont(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 360) {
      return baseSize * 0.85; // ✅ Smaller screens (Compact mobiles)
    } else if (screenWidth >= 360 && screenWidth <= 480) {
      return baseSize * 1.0; // ✅ Standard mobile screens
    } else if (screenWidth > 480 && screenWidth <= 720) {
      return baseSize * 1.2; // ✅ Tablets
    } else {
      return baseSize * 1.5; // ✅ Large screens (Laptops, PCs)
    }
  }

  static TextStyle dropDown(
    BuildContext context, {
    double fontSize = 14,
    Color color = Colors.grey,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: fontWeight,
    );
  }

  static TextStyle dropDowmLabel(
    BuildContext context, {
    double fontSize = 14,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle bold(
    BuildContext context, {
    double fontSize = 14,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle popupTitle(
    BuildContext context, {
    double fontSize = 20,
    Color color = AppColors.colorsBlue,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle popupTitleBlack(
    BuildContext context, {
    double fontSize = 20,
    Color color = AppColors.fontBlack,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle calanderDayName(
    BuildContext context, {
    double fontSize = 12,
    Color color = Colors.black,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle buttons(
    BuildContext context, {
    double fontSize = 16,
    Color color = Colors.white,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle appbarfontWhite(
    BuildContext context, {
    double fontSize = 18,
    Color color = Colors.white,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle appbarfontgrey(
    BuildContext context, {
    double fontSize = 18,
    Color color = const Color(0xff767676),
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle searchFontTitle(
    BuildContext context, {
    double fontSize = 12,
    Color color = AppColors.fontBlack,
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle searchFontSubtitle(
    BuildContext context, {
    double fontSize = 12,
    Color color = const Color(0xff767676),
  }) {
    return GoogleFonts.poppins(
      fontSize: scaleFont(context, fontSize),
      color: color,
      fontWeight: FontWeight.w400,
    );
  }
}
