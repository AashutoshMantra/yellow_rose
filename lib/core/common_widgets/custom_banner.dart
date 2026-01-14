import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class CustomBanner extends StatelessWidget {
  final String message;
  final BannerType type;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? iconColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final TextStyle? textStyle;
  final bool showIcon;
  final bool showBorder;
  final Widget? customIcon;
  final Widget? customContent;
  final VoidCallback? onTap;
  final Widget? trailing;
  final double? borderWidth;
  final double? iconSize;
  final CrossAxisAlignment alignment;
  final MainAxisAlignment mainAlignment;

  const CustomBanner({
    super.key,
    required this.message,
    this.type = BannerType.info,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.textColor,
    this.iconColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.textStyle,
    this.showIcon = true,
    this.showBorder = true,
    this.customIcon,
    this.customContent,
    this.onTap,
    this.trailing,
    this.borderWidth,
    this.iconSize,
    this.alignment = CrossAxisAlignment.center,
    this.mainAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final theme = _getBannerTheme();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(12.h),
        margin: margin ?? EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: backgroundColor ?? theme.backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.h),
          border: showBorder
              ? Border.all(
                  color: borderColor ?? theme.borderColor,
                  width: borderWidth ?? 1.0,
                )
              : null,
        ),
        child: customContent ??
            Row(
              mainAxisAlignment: mainAlignment,
              crossAxisAlignment: alignment,
              children: [
                if (showIcon) ...[
                  customIcon ??
                      Icon(
                        icon ?? theme.icon,
                        color: iconColor ?? theme.iconColor,
                        size: iconSize ?? 20.h,
                      ),
                  SizedBox(width: 8.w),
                ],
                Expanded(
                  child: Text(
                    message,
                    style: textStyle ??
                        TextStyles.bodySmallMediumStyle().copyWith(
                          color: textColor ?? theme.textColor,
                        ),
                  ),
                ),
                if (trailing != null) ...[
                  SizedBox(width: 8.w),
                  trailing!,
                ],
              ],
            ),
      ),
    );
  }

  BannerTheme _getBannerTheme() {
    switch (type) {
      case BannerType.info:
        return BannerTheme(
          backgroundColor: AppColors.primary.withOpacity(0.1),
          borderColor: AppColors.primary.withOpacity(0.3),
          textColor: AppColors.primary,
          iconColor: AppColors.primary,
          icon: Icons.info_outline,
        );
      case BannerType.warning:
        return BannerTheme(
          backgroundColor: Colors.orange.withOpacity(0.1),
          borderColor: Colors.orange.withOpacity(0.3),
          textColor: Colors.orange[800]!,
          iconColor: Colors.orange,
          icon: Icons.warning_outlined,
        );
      case BannerType.error:
        return BannerTheme(
          backgroundColor: Colors.red.withOpacity(0.1),
          borderColor: Colors.red.withOpacity(0.3),
          textColor: Colors.red[800]!,
          iconColor: Colors.red,
          icon: Icons.error_outline,
        );
      case BannerType.success:
        return BannerTheme(
          backgroundColor: Colors.green.withOpacity(0.1),
          borderColor: Colors.green.withOpacity(0.3),
          textColor: Colors.green[800]!,
          iconColor: Colors.green,
          icon: Icons.check_circle_outline,
        );
      case BannerType.custom:
        return BannerTheme(
          backgroundColor: AppColors.primaryTextSwatch[100]!,
          borderColor: AppColors.primaryTextSwatch[300]!,
          textColor: AppColors.primaryTextSwatch[900]!,
          iconColor: AppColors.primaryTextSwatch[600]!,
          icon: Icons.info_outline,
        );
    }
  }
}

enum BannerType {
  info,
  warning,
  error,
  success,
  custom,
}

class BannerTheme {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final IconData icon;

  BannerTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.icon,
  });
}
