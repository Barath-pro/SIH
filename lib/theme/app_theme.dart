import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the sports networking application.
/// Implements Contemporary Sports Performance Minimalism with Victory Gradient System.
class AppTheme {
  AppTheme._();

  // Victory Gradient System - Primary Colors
  static const Color primaryElectricBlue = Color(0xFF0066FF);
  static const Color secondarySkyBlue = Color(0xFF00AAFF);
  static const Color victoryRed = Color(0xFFFF3333);
  static const Color warmRed = Color(0xFFFF6666);
  static const Color championshipGold = Color(0xFFFFD700);
  static const Color accentGold = Color(0xFFFFA500);
  static const Color growthGreen = Color(0xFF00CC66);
  static const Color freshGreen = Color(0xFF66FF99);
  static const Color neutralCharcoal = Color(0xFF2C2C2E);
  static const Color lightGray = Color(0xFFF2F2F7);

  // Light theme surface colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFF2F2F7);
  static const Color dialogLight = Color(0xFFFFFFFF);

  // Dark theme surface colors
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF1C1C1E);
  static const Color cardDark = Color(0xFF2C2C2E);
  static const Color dialogDark = Color(0xFF2C2C2E);

  // Shadow and divider colors
  static const Color shadowLight = Color(0x1A000000); // 10% opacity
  static const Color shadowMedium = Color(0x26000000); // 15% opacity
  static const Color shadowHigh = Color(0x33000000); // 20% opacity
  static const Color dividerLight = Color(0xFFE5E5EA);
  static const Color dividerDark = Color(0xFF38383A);

  // Text colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(0xDE000000); // 87%
  static const Color textMediumEmphasisLight = Color(0x99000000); // 60%
  static const Color textDisabledLight = Color(0x61000000); // 38%

  static const Color textHighEmphasisDark = Color(0xDEFFFFFF); // 87%
  static const Color textMediumEmphasisDark = Color(0x99FFFFFF); // 60%
  static const Color textDisabledDark = Color(0x61FFFFFF); // 38%

  /// Light theme optimized for outdoor mobile usage
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryElectricBlue,
    colorScheme: const ColorScheme.light(
      primary: primaryElectricBlue,
      onPrimary: Colors.white,
      secondary: accentGold,
      onSecondary: neutralCharcoal,
      error: victoryRed,
      onError: Colors.white,
      surface: surfaceLight,
      onSurface: neutralCharcoal,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: neutralCharcoal,
      elevation: 2.0,
      shadowColor: shadowLight,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: neutralCharcoal,
      ),
      iconTheme: const IconThemeData(
        color: neutralCharcoal,
        size: 24,
      ),
    ),
    cardTheme: CardThemeData(
  color: cardLight,
  elevation: 2.0,
  shadowColor: shadowLight,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryElectricBlue,
      unselectedItemColor: textMediumEmphasisLight,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryElectricBlue,
      foregroundColor: Colors.white,
      elevation: 4.0,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: primaryElectricBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryElectricBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: primaryElectricBlue, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryElectricBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryElectricBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: victoryRed, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: victoryRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryElectricBlue,
      unselectedLabelColor: textMediumEmphasisLight,
      indicatorColor: primaryElectricBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
   dialogTheme: const DialogThemeData(
  backgroundColor: dialogLight,
),

  );

  /// Dark theme optimized for low-light conditions
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: secondarySkyBlue,
    colorScheme: const ColorScheme.dark(
      primary: secondarySkyBlue,
      onPrimary: neutralCharcoal,
      secondary: accentGold,
      onSecondary: neutralCharcoal,
      error: warmRed,
      onError: Colors.white,
      surface: surfaceDark,
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: Colors.white,
      elevation: 2.0,
      shadowColor: shadowLight,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    ),
   cardTheme: CardThemeData(
  color: cardDark,
  elevation: 2.0,
  shadowColor: shadowLight,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
  ),
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: secondarySkyBlue,
      unselectedItemColor: textMediumEmphasisDark,
      type: BottomNavigationBarType.fixed,
      elevation: 8.0,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondarySkyBlue,
      foregroundColor: neutralCharcoal,
      elevation: 4.0,
      shape: CircleBorder(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: neutralCharcoal,
        backgroundColor: secondarySkyBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 2.0,
        shadowColor: shadowLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: secondarySkyBlue,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        side: const BorderSide(color: secondarySkyBlue, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: secondarySkyBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerDark, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: secondarySkyBlue, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warmRed, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: warmRed, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: secondarySkyBlue,
      unselectedLabelColor: textMediumEmphasisDark,
      indicatorColor: secondarySkyBlue,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
  dialogTheme: const DialogThemeData(
  backgroundColor: dialogDark,
),

  );

  /// Helper method to build text theme
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color highEmphasis =
        isLight ? textHighEmphasisLight : textHighEmphasisDark;
    final Color mediumEmphasis =
        isLight ? textMediumEmphasisLight : textMediumEmphasisDark;
    final Color disabled =
        isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      displayLarge: GoogleFonts.inter(
          fontSize: 57,
          fontWeight: FontWeight.w800,
          color: highEmphasis),
      displayMedium: GoogleFonts.inter(
          fontSize: 45,
          fontWeight: FontWeight.w700,
          color: highEmphasis),
      displaySmall: GoogleFonts.inter(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: highEmphasis),
      headlineLarge: GoogleFonts.inter(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: highEmphasis),
      headlineMedium: GoogleFonts.inter(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: highEmphasis),
      headlineSmall: GoogleFonts.inter(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: highEmphasis),
      titleLarge: GoogleFonts.inter(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: highEmphasis),
      titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: highEmphasis),
      titleSmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: highEmphasis),
      bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: highEmphasis),
      bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: highEmphasis),
      bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: mediumEmphasis),
      labelLarge: GoogleFonts.roboto(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: highEmphasis),
      labelMedium: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: mediumEmphasis),
      labelSmall: GoogleFonts.roboto(
          fontSize: 11,
          fontWeight: FontWeight.w400,
          color: disabled),
    );
  }
}
class appTheme {
  // Existing colors
  static const Color primaryElectricBlue = Color(0xFF1E88E5);
  static const Color secondarySkyBlue = Color(0xFF64B5F6);
  static const Color growthGreen = Color(0xFF4CAF50);
  static const Color victoryRed = Color(0xFFE53935);
  static const Color accentGold = Color(0xFFFFC107);
  static const Color neutralCharcoal = Color(0xFF1C1C1E);

  // ... your other existing members like lightTheme, darkTheme, etc.

  // ✅ Add this static method for the gradient
  static LinearGradient getVictoryGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        growthGreen,
        primaryElectricBlue,
      ],
    );
  }
  static LinearGradient getActionGradient() {
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        primaryElectricBlue,
        secondarySkyBlue,
      ],
    );
  }
}
