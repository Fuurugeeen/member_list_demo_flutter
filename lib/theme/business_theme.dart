import 'package:flutter/material.dart';

class BusinessTheme {
  static const Color _primaryNavy = Color(0xFF1E3A8A);
  static const Color _primaryBlue = Color(0xFF3B82F6);
  static const Color _accentOrange = Color(0xFFF59E0B);
  static const Color _surfaceLight = Color(0xFFF8FAFC);
  static const Color _surfaceCard = Color(0xFFFFFFFF);
  static const Color _textPrimary = Color(0xFF1F2937);
  static const Color _textSecondary = Color(0xFF6B7280);
  static const Color _textCompany = Color(0xFF1E40AF);
  static const Color _borderLight = Color(0xFFE5E7EB);

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryBlue,
      primary: _primaryBlue,
      secondary: _accentOrange,
      surface: _surfaceLight,
      onSurface: _textPrimary,
      onSurfaceVariant: _textSecondary,
    ),
    scaffoldBackgroundColor: _surfaceLight,
    
    appBarTheme: const AppBarTheme(
      backgroundColor: _primaryNavy,
      foregroundColor: Colors.white,
      elevation: 2,
      shadowColor: Colors.black26,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 24,
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: _textPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: _textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: _textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: _textPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: _textSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _textPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _textSecondary,
      ),
    ),

    cardTheme: CardTheme(
      color: _surfaceCard,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: _borderLight,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceCard,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _borderLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _borderLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _primaryBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: const TextStyle(
        fontSize: 14,
        color: _textSecondary,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: _accentOrange,
      foregroundColor: Colors.white,
      elevation: 4,
      iconSize: 24,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryBlue,
        foregroundColor: Colors.white,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: _primaryBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    iconTheme: const IconThemeData(
      color: _textSecondary,
      size: 24,
    ),

    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      minVerticalPadding: 12,
      dense: false,
    ),
  );

  static const TextStyle memberNameStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: _textPrimary,
    height: 1.3,
  );

  static const TextStyle memberCompanyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: _textCompany,
    height: 1.3,
  );

  static const TextStyle memberDepartmentStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: _textSecondary,
    height: 1.4,
  );

  static const TextStyle memberContactStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: _textPrimary,
    height: 1.4,
  );

  static const TextStyle searchHintStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: _textSecondary,
  );

  static const EdgeInsets mobileCardPadding = EdgeInsets.all(20);
  static const EdgeInsets mobileSearchPadding = EdgeInsets.all(20);
  static const double mobileCardSpacing = 12;
  static const double mobileElementSpacing = 8;
  static const double mobileIconSize = 20;
  static const double mobileTouchTarget = 48;
}