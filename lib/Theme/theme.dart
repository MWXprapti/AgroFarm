import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color bgcolor = Color(0xFFFDFBF7);
  static const Color cream = Color(0xFFCCBF9D);
  static const Color lightcream = Color(0xFFF6F2E9);
  static const Color olive = Color(0xFFAAB883);
  static const Color yellow = Color(0xFFDFAE48);
  static const Color lightgreen = Color(0xFF456F47);
  static const Color darkgreen = Color(0xFF335441);
  static const Color textColor = Colors.black;

}

class AppTextStyles {
  static TextStyle headingStyle = GoogleFonts.poppins(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );

  static TextStyle bodyStyle = GoogleFonts.roboto(
    fontSize: 16,
    color: AppColors.textColor,
  );
}
