import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChordTheme {
  // 80s Synthwave Palette
  static const _bg = Color(0xFF05010C);
  static const _surface = Color(0xFF12042C);
  static const _card = Color(0xFF1B093D);
  
  static const _pink = Color(0xFFFF00FF);
  static const _cyan = Color(0xFF00FFFF);
  static const _purple = Color(0xFFBC13FE);
  
  static const _textPrimary = Color(0xFFFFFFFF);
  static const _textSecondary = Color(0xFFB0A2D0);

  static Color get pink => _pink;
  static Color get cyan => _cyan;
  static Color get purple => _purple;
  static Color get amber => _cyan; // Aliasing for existing code compatibility or replacing
  static Color get orange => _pink;
  static Color get cream => _textPrimary;
  static Color get card => _card;
  static Color get surface => _surface;
  static Color get bg => _bg;

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bg,
    colorScheme: const ColorScheme.dark(
      primary: _pink,
      secondary: _cyan,
      surface: _surface,
      onSurface: _textPrimary,
    ),
    cardColor: _card,
    appBarTheme: AppBarTheme(
      backgroundColor: _bg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.orbitron(
        color: _cyan, 
        fontSize: 20, 
        fontWeight: FontWeight.bold,
        letterSpacing: 1.2,
      ),
    ),
    textTheme: GoogleFonts.interTextTheme(const TextTheme(
      headlineLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: _textPrimary),
      bodyMedium: TextStyle(color: _textSecondary),
    )),
    chipTheme: const ChipThemeData(
      backgroundColor: _card,
      selectedColor: _pink,
      secondarySelectedColor: _cyan,
      labelStyle: TextStyle(color: _textPrimary),
      secondaryLabelStyle: TextStyle(color: Colors.black),
      brightness: Brightness.dark,
    ),
  );
}
