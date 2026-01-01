import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/presentation/pages/trip_detail_screen.dart';

class TripCard extends StatelessWidget {
  final TripResponse trip;
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.trip,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tripName = trip.tripName ?? 'Unnamed Trip';
    final tripStatus = trip.status;
    final statusDesc = trip.statusDesc ?? tripStatus?.description ?? '';
    final createdDate = trip.genTs;
    final totalCost = (trip.totalAirCost ?? 0) + (trip.totalHotelCost ?? 0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primarySwatch[100],
          border: Border.all(color: AppColors.primaryTextSwatch[200]!),
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      tripName,
                      style: TextStyles.bodyLargeBoldStyle(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  if (tripStatus != null)
                    Pill(
                      backgroundColor: _getStatusColor(tripStatus),
                      child: Text(
                        statusDesc,
                        style: TextStyles.bodySmallSemiBoldStyle().copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 12.h),
              if (trip.tripFor != null || trip.tripPurpose != null) ...[
                Row(
                  children: [
                    if (trip.tripFor != null) ...[
                      Icon(
                        Icons.person_outline,
                        size: 16.h,
                        color: AppColors.primaryTextSwatch[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        trip.tripFor!,
                        style: TextStyles.bodySmallMediumStyle().copyWith(
                          color: AppColors.primaryTextSwatch[600],
                        ),
                      ),
                    ],
                    if (trip.tripFor != null && trip.tripPurpose != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          '•',
                          style: TextStyles.bodySmallMediumStyle().copyWith(
                            color: AppColors.primaryTextSwatch[400],
                          ),
                        ),
                      ),
                    if (trip.tripPurpose != null)
                      Expanded(
                        child: Text(
                          trip.tripPurpose!,
                          style: TextStyles.bodySmallMediumStyle().copyWith(
                            color: AppColors.primaryTextSwatch[600],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 8.h),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (createdDate != null)
                    Text(
                      'Created ${CustomDateUtils.givenFormat(createdDate, "dd MMM yyyy")}',
                      style: TextStyles.bodySmallMediumStyle().copyWith(
                        color: AppColors.primaryTextSwatch[500],
                      ),
                    ),
                  if (totalCost > 0)
                    Text(
                      '₹${totalCost.toStringAsFixed(0)}',
                      style: TextStyles.bodyMediumSemiBoldStyle().copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(status) {
    // Map status to colors similar to order status
    switch (status.code) {
      case 'A': // APPROVED
      case 'B': // BOOKED
      case 'C': // COMPLETE
        return Colors.green;
      case 'P': // PENDING
      case 'I': // APPROVAL INITIATED
      case 'R': // SUBMITTED
        return Colors.orange;
      case 'D': // DECLINED/CANCEL
      case 'F': // FAILED
        return Colors.red;
      case 'N': // NEW
      case 'G': // DRAFT
        return AppColors.primary;
      default:
        return AppColors.primaryTextSwatch[400]!;
    }
  }
}
