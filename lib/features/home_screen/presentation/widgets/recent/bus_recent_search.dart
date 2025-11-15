import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';

class BusRecentSearchCard extends StatelessWidget {
  final BusSearch recentSearch;
  final VoidCallback? onTap;
  const BusRecentSearchCard(
      {super.key, required this.recentSearch, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryTextSwatch[200]!),
            borderRadius: BorderRadius.circular(8)),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 145.h),
          child: Container(
            padding: EdgeInsets.all(16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "${recentSearch.source?.cityName ?? ""} -> ${recentSearch.destination?.cityName ?? ""}",
                  style: TextStyles.bodyMediumBoldStyle(),
                ),
                Text(
                  CustomDateUtils.givenFormat(
                      recentSearch.dateOfJourney ?? DateTime.now(),
                      "dd MMM yyyy"),
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.directions_bus,
                      color: AppColors.primaryTextSwatch[600],
                      size: 14.h,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    Text(
                      "Bus",
                      style: TextStyles.bodySmallMediumStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
