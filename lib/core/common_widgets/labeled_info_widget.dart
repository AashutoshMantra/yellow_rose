import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class LabeledInfoWidget extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String content;
  final Function()? onCLick;
  final Widget? body;
  const LabeledInfoWidget(
      {super.key,
      this.leading,
      required this.title,
      required this.content,
      this.onCLick,
      this.body});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCLick,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryTextSwatch[50],
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: body ??
              Row(
                children: [
                  if (leading != null)
                    Container(
                        margin: EdgeInsets.only(right: 12.w), child: leading!),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyles.bodySmallMediumStyle()
                              .copyWith(color: AppColors.primarySwatch[500]),
                        ),
                        Text(
                          content,
                          style: TextStyles.bodyMediumSemiBoldStyle()
                              .copyWith(color: AppColors.primaryText),
                        ),
                      ],
                    ),
                  )
                ],
              ),
        ),
      ),
    );
  }
}
