import 'package:flutter/material.dart';

class ParagraphText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  const ParagraphText(
    this.text, {
    this.textAlign,
    this.overflow,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: const TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
