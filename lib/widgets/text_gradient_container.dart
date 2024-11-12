

import 'package:flutter/material.dart';

class TextGradientContainer extends StatelessWidget {
  final String text;
  final double textSize;
  const TextGradientContainer({super.key, required this.text, required this.textSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFA726),
            Colors.grey, 
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 2.0),
        child: Text(
          text, 
          style: TextStyle(color: Colors.white.withOpacity(0.85),fontSize: textSize, fontWeight: FontWeight.w600)
        ),
      ),
    );
  }
}