import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class LabeledContainerField extends StatelessWidget {
  final String label;
  final Widget? child;

  const LabeledContainerField({
    super.key,
    required this.label,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.h6Style().copyWith(color: AppColors.primary),
          ),
          SizedBox(height: 16.h),
          if (child != null) child!
        ],
      ),
    );
  }
}
