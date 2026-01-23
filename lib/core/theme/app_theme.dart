import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppPalette.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppPalette.accentBlue,
        onPrimary: Colors.white,
        surface: AppPalette.lightBackground,
        onSurface: AppPalette.lightTextPrimary,
        surfaceContainerHighest: AppPalette.lightSurface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.lightTextPrimary,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.lightTextPrimary,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.lightTextPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppPalette.lightTextPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppPalette.lightTextPrimary,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppPalette.lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppPalette.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppPalette.accentBlue,
        onPrimary: Colors.white,
        surface: AppPalette.darkBackground,
        onSurface: AppPalette.darkTextPrimary,
        surfaceContainerHighest: AppPalette.darkSurface,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.darkTextPrimary,
        ),
        displayMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.darkTextPrimary,
        ),
        headlineMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          color: AppPalette.darkTextPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          color: AppPalette.darkTextPrimary,
        ),
        bodyMedium: GoogleFonts.inter(
          color: AppPalette.darkTextPrimary,
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppPalette.darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }
}
