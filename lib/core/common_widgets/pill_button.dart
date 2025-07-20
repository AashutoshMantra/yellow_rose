import 'package:flutter/material.dart';

import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

enum PillType { primary, secondary }

class PillButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final PillType pillType;
  final Function()? onClick;
  final Color? borderColor;
  const PillButton({
    super.key,
    this.child,
    this.text,
    this.pillType = PillType.primary,
    this.onClick,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ??
                    (pillType == PillType.primary
                        ? Colors.transparent
                        : AppColors.primary)),
            color: (pillType == PillType.primary
                ? AppColors.primary
                : Colors.white),
            borderRadius: BorderRadius.circular(24.h)),
        child: DefaultTextStyle(
          style: TextStyles.bodySmallSemiBoldStyle().copyWith(
              color: pillType == PillType.primary
                  ? Colors.white
                  : AppColors.primary),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0.h, horizontal: 6.w),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: child ??
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
