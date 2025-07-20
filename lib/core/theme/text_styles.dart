import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class TextStyles {
  TextStyles._();

  static const String fontFamily = 'Roboto'; 

  static const FontWeight bold = FontWeight.bold;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight regular = FontWeight.normal;

  static TextStyle h1Style() {
    return  TextStyle(
      fontSize: 48.0.h, 
      fontWeight: bold, 
      fontFamily: fontFamily,
      color: AppColors.primaryText
    );
  }

  static TextStyle h2Style() {
    return  TextStyle(
      fontSize: 40.0.h, 
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle h3Style() {
    return  TextStyle(
      fontSize: 28.0.h, // 24px for h3 in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle h4Style() {
    return  TextStyle(
      fontSize: 24.0.h, // 22px for h4 in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle h5Style() {
    return  TextStyle(
      fontSize: 20.0.h, // 20px for h5 in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle h6Style() {
    return  TextStyle(
      fontSize: 16.0.h, // 18px for h6 in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  // Mapping Figma's Body Text styles to Material 3
  static TextStyle bodyLargeStyle() {
    return  TextStyle(
      fontSize: 16.0.h, // 16px for body large in Figma
      fontWeight: regular,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyLargeBoldStyle() {
    return  TextStyle(
      fontSize: 16.0.h, // 16px for body large in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyLargeSemiBoldStyle() {
    return  TextStyle(
      fontSize: 16.0.h, // 16px for body large in Figma
      fontWeight: semiBold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyLargeMediumStyle() {
    return  TextStyle(
      fontSize: 16.0.h, // 16px for body large in Figma
      fontWeight: medium,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle bodyMediumStyle() {
    return  TextStyle(
      fontSize: 14.0.h, // 14px for body medium in Figma
      fontWeight: regular,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyMediumBoldStyle() {
    return  TextStyle(
      fontSize: 14.0.h, // 14px for body medium in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyMediumSemiBoldStyle() {
    return  TextStyle(
      fontSize: 14.0.h, // 14px for body medium in Figma
      fontWeight: semiBold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyMediumMediumStyle() {
    return  TextStyle(
      fontSize: 14.0.h, // 14px for body medium in Figma
      fontWeight: medium,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle bodySmallStyle() {
    return  TextStyle(
      fontSize: 12.0.h, // 12px for body small in Figma
      fontWeight: regular,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodySmallBoldStyle() {
    return  TextStyle(
      fontSize: 12.0.h, // 12px for body small in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodySmallSemiBoldStyle() {
    return  TextStyle(
      fontSize: 12.0.h, // 12px for body small in Figma
      fontWeight: semiBold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodySmallMediumStyle() {
    return  TextStyle(
      fontSize: 12.0.h, // 12px for body small in Figma
      fontWeight: medium,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

  static TextStyle bodyXLargeStyle() {
    return  TextStyle(
      fontSize: 18.0.h, // 18px for body x-large in Figma
      fontWeight: regular,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyXLargeBoldStyle() {
    return  TextStyle(
      fontSize: 18.0.h, // 18px for body x-large in Figma
      fontWeight: bold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyXLargeSemiBoldStyle() {
    return  TextStyle(
      fontSize: 18.0.h, // 18px for body x-large in Figma
      fontWeight: semiBold,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }
  static TextStyle bodyXLargeMediumStyle() {
    return  TextStyle(
      fontSize: 18.0.h, // 18px for body x-large in Figma
      fontWeight: medium,
      fontFamily: fontFamily,
       color: AppColors.primaryText
    );
  }

}