import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class AppTheme {
  static ColorScheme appColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: Colors.white, // Text/icon color on primary
    secondary: AppColors.secondaryButton,
    onSecondary: Colors.white, // Text/icon color on secondary
    error: AppColors.error,
    onError: Colors.white,
    surface: AppColors.secondaryButton, // For secondary buttons
    onSurface: AppColors.primaryText, // Text/icon color on secondary
  );
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      colorScheme: appColorScheme,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyles.h6Style().copyWith(color: Colors.white)),
      scaffoldBackgroundColor: Colors.white,
      useMaterial3: true,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          textStyle: TextStyles.bodyMediumBoldStyle().copyWith(
            color: Colors.white,
          ),
          disabledBackgroundColor: AppColors.disabledButton, // Disabled state
          disabledForegroundColor: Colors.white, // Disabled text color
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledForegroundColor: Colors.grey,
          overlayColor: AppColors.primary,
          side: const BorderSide(
            color: AppColors.primary,
          ),
          textStyle: TextStyles.bodySmallSemiBoldStyle(),
          foregroundColor:
              AppColors.primarySwatch[400], // Text for secondary buttons
        ).copyWith(
          side: WidgetStateProperty.resolveWith<BorderSide>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                BorderSide(color: AppColors.primaryTextSwatch[100]!);
              }
              return BorderSide(
                color: Theme.of(context).primaryColor,
              );
              // Defer to the widget's default.
            },
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.icon, // Icon color
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: EdgeInsets.zero,
      )),
      cardTheme: CardThemeData(
        color: AppColors.containerBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
