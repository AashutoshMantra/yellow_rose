import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class DasshedArrowLine extends StatelessWidget {
  const DasshedArrowLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: DottedLine(
              alignment: WrapAlignment.center,
              dashColor: AppColors.primarySwatch[400]!,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-5.w, 0),
          child: Icon(
            Icons.arrow_forward_ios,
            color: AppColors.primarySwatch[400]!,
            size: 14.h,
          ),
        )
      ],
    );
  }
}
