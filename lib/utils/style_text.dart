import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText extends StatelessWidget {
  final String text;
  const StyleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.poppins(
            fontSize: 24, fontWeight: FontWeight.w500, color: Colors.blue));
  }
}
