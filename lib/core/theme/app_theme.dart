import 'package:flutter/material.dart';

class AppTheme {
  // Academic Color Palette - inspired by educational institutions
  static const Color primaryBlue = Color(0xFF2E5C8A);      // Professional blue from logo
  static const Color accentBlue = Color(0xFF4A90C8);       // Lighter accent blue
  static const Color darkNavy = Color(0xFF1A3A52);         // Deep navy for contrast
  static const Color softCream = Color(0xFFF8F6F1);        // Warm off-white background
  static const Color warmGray = Color(0xFF6B7280);         // Neutral gray for text
  static const Color scholarGreen = Color(0xFF2D5F3F);     // Academic green accent

  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color errorColor = Color(0xFFDC2626);

  // LIGHT THEME (Clean Academic)
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: softCream,
    primaryColor: primaryBlue,
    colorScheme: ColorScheme.light(
      primary: primaryBlue,
      secondary: scholarGreen,
      surface: Colors.white,
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: warmGray.withValues(alpha: .3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryBlue, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
      hintStyle: TextStyle(color: textSecondary),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: textPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: textSecondary, fontSize: 14),
      titleLarge: TextStyle(
        color: primaryBlue,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scholarGreen,
      foregroundColor: Colors.white,
    ),
  );

  // DARK THEME (Professional Night Mode)
  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF111827),
    primaryColor: accentBlue,
    colorScheme: ColorScheme.dark(
      primary: accentBlue,
      secondary: scholarGreen,
      surface: Color(0xFF1F2937),
      error: errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: darkNavy,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 20,
        letterSpacing: 0.15,
      ),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1F2937),
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: warmGray.withValues(alpha: .3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: accentBlue, width: 2),
      ),
      filled: true,
      fillColor: Color(0xFF374151),
      hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 16),
      bodyMedium: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
      titleLarge: TextStyle(
        color: accentBlue,
        fontWeight: FontWeight.w700,
        fontSize: 24,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: scholarGreen,
      foregroundColor: Colors.white,
    ),
  );
}