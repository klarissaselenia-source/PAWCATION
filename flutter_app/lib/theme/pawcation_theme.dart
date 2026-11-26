import 'package:flutter/material.dart';

class PawcationColors {
  PawcationColors._();

  // Brand Blues (extracted from Figma screens)
  static const Color primary = Color(0xFF0FA5E9);
  static const Color primaryDark = Color(0xFF0284C7);
  static const Color primarySoft = Color(0xFFE6F4FD);
  static const Color primaryTint = Color(0xFFF0F7FC);
  static const Color biometricBg = Color(0xFFE5F2FA);
  static const Color navyAccent = Color(0xFF0B4F6C);

  // Surfaces & Backgrounds
  static const Color scaffoldBg = Color(0xFFF4F8FC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color inputFill = Color(0xFFF3F5F8);
  static const Color border = Color(0xFFE6EEF5);
  static const Color divider = Color(0xFFE2E8F0);

  // Text Hierarchy
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Semantic Status
  static const Color success = Color(0xFF0D9488);
  static const Color successSoft = Color(0xFFE6F7F4);
  static const Color warning = Color(0xFFD97706);
  static const Color warningSoft = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFEF4444);
  static const Color dangerSoft = Color(0xFFFEE2E2);
}

class PawcationTheme {
  PawcationTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: PawcationColors.scaffoldBg,
      colorScheme: ColorScheme.fromSeed(
        seedColor: PawcationColors.primary,
        primary: PawcationColors.primary,
        surface: PawcationColors.white,
      ),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: PawcationColors.white,
        foregroundColor: PawcationColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),
      dividerColor: PawcationColors.divider,
    );
  }

  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF0F172A).withValues(alpha: 0.045),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];
}
