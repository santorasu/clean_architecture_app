import 'package:flutter/material.dart';

/// Centralized color palette for the app.
/// Defines both light and dark theme colors.
class ColorManager {
  ColorManager._();

  // ===== Primary Colors =====
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF334289);
  static const Color primaryDark = Color(0xFF000C48);

  // ===== Background Colors =====
  static const Color background = Color(0xFFF8FAFC);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color iconBackground = Color(0xFF2563EB);
  static const Color scaffoldLight = Color(0xFFFFFFFF);
  static const Color scaffoldDark = Color(0xFF1E1E1E);
  static const Color foundationGreen = Color(0xFFB0FCD4);
  static const Color foundationGreenDark = Color(0xFF008640);

  // ===== Text Colors =====
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color additionalColorWhite = Color(0xFFFEFEFE);
  static const Color grayscale70 = Color(0xFF78828A);
  static const Color grayscale60 = Color(0xFF9CA4AB);
  static const Color subtitleText = Color(0xFFA5A5AB);
  static const Color subtitleText1 = Color(0xFF60655C);
  static const Color mediumText = Color(0xFF363A33);

  // ===== Button & Label Colors =====
  static const Color buttonText = Color(0xFF201E1E);
  static const Color hintText = Color(0xFF5B5F5F);

  // ===== Neutral Colors =====
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color transparentColor = Colors.transparent;

  // ===== Border Colors =====
  static const Color borderColor = Color(0xFFDADADA);
  static const Color borderColor1 = Color(0xFF00136B);

  // ===== Container & Fill Colors =====
  static const Color containerColor = Color(0xFF707070);
  static const Color containerColor1 = Color(0xFFF6F8FE);
  static const Color fillColor = Color(0xFFFEF5F3);

  // ===== Feedback Colors =====
  static const Color errorColor = Color(0xFFE25839);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFFFA000);
  static const Color infoColor = Color(0xFF1976D2);

  // ===== Utility Colors =====
  static const Color shadowColor = Color(0x1A000000); // 10% opacity black
  static const Color dividerColor = Color(0xFFE0E0E0);
  static const Color overlayColor = Color(0x33000000); // 20% opacity black
}
