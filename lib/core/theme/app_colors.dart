import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1F48AA); // AppBar and enabled buttons
  static const Color primaryText =
      Color(0xFF111827); // White text on enabled buttons
  static const Color disabledButton = Color(0xFFBCD6EB); // Disabled buttons
  static const Color secondaryButton =
      Color(0xFFF3F4F6); // Secondary/cancel/back buttons
  static const Color icon =
      Color(0xFF1F48AA); // Icon color in circular containers
  static const Color containerBackground =
      Color(0xFFF0F6FA); // Circular container background
  static const Color primaryGreen = Color(0xFF12A58C); // Primary green
  static const Color error = Color(0xFFF6285F); // Error primary color
  static const Color warning = Color(0xFFFFDF6E);
  static const Color outlineColor = Color(0xffE5E7EB); // Warning primary color

  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFF0F6FA), // Lightest shade
    100: Color(0xFFE7EEFF),
    200: Color(0xFFBCD6EB),
    300: Color(0xFF95BADE),
    400: Color(0xFF5481C4),
    500: primary, // Base primary color
    600: Color(0xFF1A419A),
    700: Color(0xFF173A8F),
    800: Color(0xFF123086),
    900: Color(0xFF0E276D), // Darkest shade
  };
  static const Map<int, Color> primarySuccessSwatch = {
    50: Color(0xFFFAFFFE), // Lightest shade
    100: Color(0xFFF0F9F8),
    200: Color(0xFFD0EDE8),
    300: Color(0xFFA0DBD1),
    400: Color(0xFF71C9BA),
    500: Color(0xFF41B7A3), // Base primary color
    600: primaryGreen,
    700: primaryGreen,
    800: primaryGreen,
    900: primaryGreen,
  };

  static const Map<int, Color> primaryTextSwatch = {
    50: Color(0xFFF9FAFB), // Lightest shade
    100: Color(0xFFF3F4F6),
    200: Color(0xFFE5E7EB),
    300: Color(0xFFD1D5DB),
    400: Color(0xFF9CA3AF),
    500: Color(0xFF6B7280), // Base primary color
    600: Color(0xFF4B5563),
    700: Color(0xFF374151),
    800: Color(0xFF1F2937),
    900: primaryText, // Darkest shade
  };
  static const Map<int, Color> errorSwatch = {
    50: Color(0xFFFFFAFB), // Lightest shade
    100: Color(0xFFFFF5F8),
    200: Color(0xFFFDD4DF),
    300: Color(0xFFFBA9BF),
    400: Color(0xFFFA7E9F),
    500: Color(0xFFF8537F), // Base primary color
    600: error,
    700: error,
    800: error,
    900: error,
  };
}
