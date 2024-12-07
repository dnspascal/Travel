// import 'package:flutter/material.dart';

// final ThemeData appTheme = ThemeData(
//   primarySwatch: Colors.blue,
//   inputDecorationTheme: InputDecorationTheme(
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(25),
//     ),
//     contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//     labelStyle: const TextStyle(
//       color: Colors.black,
//       fontSize: 16,
//     ),
//     hintStyle: const TextStyle(
//       color: Color(0XFF3b3abe),
//       fontSize: 16,
//     ),
//   ),
// );

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF2D8EFF),
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.quicksandTextTheme(),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2D8EFF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF9CA3AF)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF2D8EFF)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D8EFF),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
