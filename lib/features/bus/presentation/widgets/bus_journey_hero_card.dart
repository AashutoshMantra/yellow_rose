import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';

class BusJourneyHeroCard extends StatelessWidget {
  final BusSearchResponse busInfo;
  final int seatCount;

  const BusJourneyHeroCard({
    super.key,
    required this.busInfo,
    required this.seatCount,
  });

  String _formatTime(DateTime? value) {
    if (value == null) return '--';
    return CustomDateUtils.timeInAmPm(value);
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '--';
    return CustomDateUtils.dayDateMonthFormat(value);
  }

  @override
  Widget build(BuildContext context) {
    final operatorName =
        busInfo.operatorDetails?.operatorName ?? 'Bus Operator';
    final route = '${busInfo.source ?? ''} → ${busInfo.destination ?? ''}';
    final departureLabel = _formatTime(busInfo.departureTime);
    final departureDate = _formatDate(busInfo.departureTime);
    final arrivalLabel = _formatTime(busInfo.arrivalTime);
    final arrivalDate = _formatDate(busInfo.arrivalTime);
    final duration = busInfo.duration ?? '--';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xffF0F9FF), Color(0xffF9FBFF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.w),
        border: Border.all(color: AppColors.primarySwatch[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            operatorName,
            style: TextStyles.bodyLargeSemiBoldStyle(),
          ),
          SizedBox(height: 4.h),
          Text(route, style: TextStyles.bodySmallMediumStyle()),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              if ((busInfo.busType ?? '').isNotEmpty)
                _InfoChip(label: busInfo.busType!),
              _InfoChip(label: (busInfo.aC ?? false) ? 'AC' : 'Non-AC'),
              _InfoChip(
                  label: (busInfo.sleeper ?? false) ? 'Sleeper' : 'Seater'),
              _InfoChip(label: '$seatCount seat${seatCount > 1 ? 's' : ''}'),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _JourneySlot(
                  label: 'Departure',
                  time: departureLabel,
                  date: departureDate,
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                children: [
                  const Icon(Icons.directions_bus, color: AppColors.primary),
                  SizedBox(height: 4.h),
                  Text(duration, style: TextStyles.bodySmallMediumStyle()),
                ],
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _JourneySlot(
                  label: 'Arrival',
                  time: arrivalLabel,
                  date: arrivalDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _JourneySlot extends StatelessWidget {
  final String label;
  final String time;
  final String date;

  const _JourneySlot({
    required this.label,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.w),
        color: Colors.white,
        border: Border.all(color: AppColors.primarySwatch[100]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyles.bodySmallMediumStyle()),
          SizedBox(height: 4.h),
          Text(
            time,
            style: TextStyles.bodyLargeBoldStyle(),
          ),
          SizedBox(height: 2.h),
          Text(date,
              style: TextStyles.bodySmallMediumStyle()
                  .copyWith(color: AppColors.primaryTextSwatch[500])),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primarySwatch[50],
        borderRadius: BorderRadius.circular(20.w),
      ),
      child: Text(
        label,
        style: TextStyles.bodySmallMediumStyle(),
      ),
    );
  }
}
