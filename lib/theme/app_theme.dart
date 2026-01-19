import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  
  
  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0E1117),
      primaryColor: const Color(0xFF7C3AED),

      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF7C3AED),
        secondary: Color(0xFF4F46E5),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0E1117),
        elevation: 0,
      ),

      cardTheme: CardThemeData(
        color: const Color(0xFF111827),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF111827),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),

      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF7C3AED),
      ),
    );
  }
}
