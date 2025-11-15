import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class BottomButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String buttonText;
  final Function() onClick;

  const BottomButton({
    super.key,
    required this.title,
    this.subtitle,
    required this.onClick,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primarySwatch[100],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 12.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title.isNotEmpty)
                    Text(
                      title,
                      style: TextStyles.bodyXLargeBoldStyle()
                          .copyWith(color: AppColors.primary),
                    ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TextStyles.bodySmallMediumStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                    )
                ],
              ),
            ),
            if (title.isNotEmpty) const Spacer(),
            Flexible(
              child: CustomButton(
                text: buttonText,
                onPressed: onClick,
              ),
            ),
            if (title.isEmpty) const Spacer(),
          ],
        ),
      ),
    );
  }
}
