import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class SeatMapLegends extends StatelessWidget {
  const SeatMapLegends({super.key});

  @override
  Widget build(BuildContext context) {
    final legends = [
      {"color": AppColors.primaryGreen, "text": "Free"},
      {"color": AppColors.primarySuccessSwatch[400], "text": "Paid"},
      {"color": AppColors.primary, "text": "Selected"},
      {"color": AppColors.primaryTextSwatch[300]!, "text": "Occupied"},
    ];
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: AppColors.primary)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Wrap(
        children: legends.map((legend) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: legend["color"] as Color,
                  height: 12.h,
                  width: 12.h,
                ),
                SizedBox(
                  width: 4.h,
                ),
                Text(
                  legend["text"] as String,
                  style: TextStyles.bodyMediumSemiBoldStyle(),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
