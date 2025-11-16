import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';

class PointCard extends StatelessWidget {
  final BusPoint point;
  final bool isSelected;
  final VoidCallback onTap;

  const PointCard({
    super.key,
    required this.point,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Use shared date utilities for formatting
    final timeString =
        point.time != null ? CustomDateUtils.timeIn24(point.time!) : '--:--';

    final dateString = point.time != null
        ? CustomDateUtils.givenFormat(point.time!, 'd MMM')
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primary.withOpacity(0.06) : Colors.white,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade200,
            width: isSelected ? 2.w : 1.w,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Leading: prominent time + date
            Container(
              width: 78.w,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.12)
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8.h),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    timeString,
                    style: TextStyles.bodyLargeBoldStyle().copyWith(
                      fontSize: 16.h,
                      color: isSelected ? AppColors.primary : Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    dateString,
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: Colors.grey.shade600,
                      fontSize: 12.h,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: 12.w),

            // Middle: location + address
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    point.location ?? 'Unknown Location',
                    style: TextStyles.bodyLargeBoldStyle().copyWith(
                      fontSize: 15.h,
                      color: isSelected ? AppColors.primary : Colors.black87,
                      fontWeight: FontWeight.w800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6.h),
                  if (point.address != null && point.address!.isNotEmpty)
                    Text(
                      point.address!,
                      style: TextStyles.bodySmallStyle().copyWith(
                        color: Colors.grey.shade700,
                        fontSize: 13.h,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      if (point.contactNumber != null &&
                          point.contactNumber!.isNotEmpty) ...[
                        Icon(
                          Icons.phone_outlined,
                          size: 14.w,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          point.contactNumber!,
                          style: TextStyles.bodySmallStyle().copyWith(
                            color: Colors.grey.shade700,
                            fontSize: 12.h,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Right: prime badge + selection indicator
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (point.prime == 'true')
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 12.w,
                          color: AppColors.primary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Prime',
                          style: TextStyles.bodySmallBoldStyle().copyWith(
                            color: AppColors.primary,
                            fontSize: 11.h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                SizedBox(height: 10.h),

                // Selection circle
                Container(
                  width: 26.w,
                  height: 26.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.white,
                    border: Border.all(
                      color:
                          isSelected ? AppColors.primary : Colors.grey.shade400,
                      width: 2.w,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 14.w,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
