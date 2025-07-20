import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class TitleFormWidget extends StatelessWidget {
  final String text;
  final Widget child;
  const TitleFormWidget({super.key, required this.text, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 22.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyles.bodyMediumMediumStyle()
                .copyWith(color: AppColors.primaryTextSwatch[600]),
          ),
          child
        ],
      ),
    );
  }
}
