import 'package:flutter/material.dart';

class StyleText extends StatelessWidget { 
  final String text ; 
  const StyleText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(text , style: const TextStyle(
      color: Color(0xFF1380FE),
      fontSize: 24,
      fontWeight: FontWeight.bold,
      
    ),);
  }
}