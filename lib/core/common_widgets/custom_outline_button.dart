import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

enum OutlinedButtonType { primary, danger, secondary }

class CustomOutlinedButton extends StatelessWidget {
  final OutlinedButtonType buttonType;
  final Function()? onPressed;
  final String text;
  final TextStyle? textStyleOverride; // 👈 new field

  const CustomOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.buttonType = OutlinedButtonType.primary,
    this.textStyleOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Base style from global theme
    final baseStyle = Theme.of(context).outlinedButtonTheme.style;

    // Variant colors
    final Color activeColor;
    switch (buttonType) {
      case OutlinedButtonType.primary:
        activeColor = AppColors.primary;
        break;
      case OutlinedButtonType.danger:
        activeColor = AppColors.error;
        break;
      case OutlinedButtonType.secondary:
        activeColor = AppColors.primaryTextSwatch[200]!;
        break;
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: baseStyle?.copyWith(
        foregroundColor: WidgetStateProperty.resolveWith<Color>(
          (states) =>
              states.contains(WidgetState.disabled) ? Colors.grey : activeColor,
        ),
        side: WidgetStateProperty.resolveWith<BorderSide>(
          (states) => BorderSide(
            color: states.contains(WidgetState.disabled)
                ? Colors.grey
                : activeColor,
          ),
        ),
        textStyle: WidgetStateProperty.all(
          // 👇 merge global style + override
          (baseStyle.textStyle?.resolve({}) ?? TextStyles.bodyMediumBoldStyle())
              .copyWith(
            fontFamily: textStyleOverride?.fontFamily,
            fontSize: textStyleOverride?.fontSize,
            fontWeight: textStyleOverride?.fontWeight,
            color: textStyleOverride?.color,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Text(text),
      ),
    );
  }
}
