import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChordTheme {
  static const _bg = Color(0xFF1A1208);
  static const _surface = Color(0xFF2A1E10);
  static const _card = Color(0xFF352716);
  static const _amber = Color(0xFFE8A838);
  static const _orange = Color(0xFFFF8C42);
  static const _cream = Color(0xFFF5E6CC);
  static const _textPrimary = Color(0xFFF0E0C8);
  static const _textSecondary = Color(0xFFA08860);

  static Color get amber => _amber;
  static Color get orange => _orange;
  static Color get cream => _cream;
  static Color get card => _card;
  static Color get surface => _surface;
  static Color get bg => _bg;

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: _bg,
    colorScheme: const ColorScheme.dark(
      primary: _amber,
      secondary: _orange,
      surface: _surface,
    ),
    cardColor: _card,
    appBarTheme: AppBarTheme(
      backgroundColor: _bg,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.inter(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold),
    ),
    textTheme: GoogleFonts.interTextTheme(const TextTheme(
      headlineLarge: TextStyle(color: _textPrimary, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(color: _textPrimary),
      bodyMedium: TextStyle(color: _textSecondary),
    )),
  );
}
