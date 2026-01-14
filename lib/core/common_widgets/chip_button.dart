import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

enum ChipType {
  primary,
  secondary,
  success,
  warning,
  error,
}

class ChipButton extends StatelessWidget {
  final String text;
  final ChipType chipType;
  final Widget? leadingIcon;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const ChipButton({
    super.key,
    required this.text,
    this.chipType = ChipType.primary,
    this.leadingIcon,
    this.onRemove,
    this.onTap,
  });

  Color get _backgroundColor {
    switch (chipType) {
      case ChipType.primary:
        return AppColors.primarySwatch[50]!;
      case ChipType.secondary:
        return AppColors.primaryTextSwatch[50]!;
      case ChipType.success:
        return Colors.green.shade50;
      case ChipType.warning:
        return Colors.orange.shade50;
      case ChipType.error:
        return Colors.red.shade50;
    }
  }

  Color get _borderColor {
    switch (chipType) {
      case ChipType.primary:
        return AppColors.primarySwatch[200]!;
      case ChipType.secondary:
        return AppColors.primaryTextSwatch[200]!;
      case ChipType.success:
        return Colors.green.shade200;
      case ChipType.warning:
        return Colors.orange.shade200;
      case ChipType.error:
        return Colors.red.shade200;
    }
  }

  Color get _textColor {
    switch (chipType) {
      case ChipType.primary:
        return AppColors.primaryTextSwatch[700]!;
      case ChipType.secondary:
        return AppColors.primaryTextSwatch[600]!;
      case ChipType.success:
        return Colors.green.shade700;
      case ChipType.warning:
        return Colors.orange.shade700;
      case ChipType.error:
        return Colors.red.shade700;
    }
  }

  Color get _deleteIconColor {
    switch (chipType) {
      case ChipType.primary:
        return AppColors.primaryTextSwatch[600]!;
      case ChipType.secondary:
        return AppColors.primaryTextSwatch[500]!;
      case ChipType.success:
        return Colors.green.shade600;
      case ChipType.warning:
        return Colors.orange.shade600;
      case ChipType.error:
        return Colors.red.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Chip(
        avatar: leadingIcon,
        label: Text(
          text,
          style: TextStyles.bodySmallStyle().copyWith(
            color: _textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        deleteIcon: onRemove != null
            ? Icon(
                Icons.close,
                size: 18,
                color: _deleteIconColor,
              )
            : null,
        onDeleted: onRemove,
        backgroundColor: _backgroundColor,
        side: BorderSide(
          color: _borderColor,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      ),
    );
  }
}
