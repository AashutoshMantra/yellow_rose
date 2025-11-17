import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class BusTimelineEntry {
  final String title;
  final String? location;
  final String time;
  final String? address;

  const BusTimelineEntry({
    required this.title,
    required this.location,
    required this.time,
    required this.address,
  });
}

class BusJourneyTimeline extends StatelessWidget {
  final List<BusTimelineEntry> entries;

  const BusJourneyTimeline({
    super.key,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(entries.length, (index) {
        final entry = entries[index];
        final isLast = index == entries.length - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  _TimelineIndicator(),
                  if (!isLast)
                    Container(
                      width: 2.w,
                      height: 50.h,
                      color: AppColors.primarySwatch[100],
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.title, style: TextStyles.bodySmallBoldStyle()),
                    SizedBox(height: 4.h),
                    Text(entry.location ?? '--',
                        style: TextStyles.bodyMediumSemiBoldStyle()),
                    SizedBox(height: 3.h),
                    Text(entry.time,
                        style: TextStyles.bodySmallMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500])),
                    if ((entry.address ?? '').isNotEmpty)
                      Text(entry.address!,
                          style: TextStyles.bodySmallStyle().copyWith(
                              color: AppColors.primaryTextSwatch[400])),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _TimelineIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18.w,
      height: 18.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary, width: 2.w),
      ),
      child: Center(
        child: Container(
          width: 6.w,
          height: 6.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
