import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasised;
  final TextAlign valueAlign;
  final Color? valueColor;

  const KeyValueRow({
    super.key,
    required this.label,
    required this.value,
    this.emphasised = false,
    this.valueAlign = TextAlign.right,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: emphasised
                  ? TextStyles.bodyMediumBoldStyle()
                  : TextStyles.bodySmallMediumStyle(),
            ),
          ),
          SizedBox(width: 12.w),
          Flexible(
            child: Text(
              value,
              textAlign: valueAlign,
              style: emphasised
                  ? TextStyles.bodyLargeBoldStyle().copyWith(
                      color: valueColor ?? AppColors.primary,
                    )
                  : TextStyles.bodyMediumSemiBoldStyle().copyWith(
                      color: valueColor ?? AppColors.primaryText,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
