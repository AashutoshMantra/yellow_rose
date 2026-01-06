import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';

class TripStatusBanner extends StatelessWidget {
  final TripResponse trip;

  const TripStatusBanner({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final status = trip.status;
    if (status == null) return const SizedBox.shrink();

    final statusColor = _getStatusColor(status);
    final statusIcon = _getStatusIcon(status);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            statusColor.withOpacity(0.15),
            statusColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: statusColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: statusColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                statusIcon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Current Status',
                    style: TextStyles.bodySmallStyle().copyWith(
                      color: AppColors.primaryTextSwatch[500],
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.description,
                    style: TextStyles.bodyLargeBoldStyle().copyWith(
                      color: statusColor,
                      fontSize: 18,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                status.code,
                style: TextStyles.bodySmallBoldStyle().copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(TripStatusEnum status) {
    switch (status) {
      case TripStatusEnum.NEW:
      case TripStatusEnum.DRAFT:
        return AppColors.primary;
      case TripStatusEnum.PENDING:
      case TripStatusEnum.APPROVALINITIATED:
      case TripStatusEnum.SUBMITTED:
      case TripStatusEnum.PENDINGAIR:
      case TripStatusEnum.PENDINGHOTEL:
      case TripStatusEnum.TOTALPENDING:
      case TripStatusEnum.PARTIALLYAPPROVED:
        return Colors.orange;
      case TripStatusEnum.APPROVED:
      case TripStatusEnum.SELFAPPROVED:
      case TripStatusEnum.BOOKED:
      case TripStatusEnum.COMPLETE:
      case TripStatusEnum.PAID:
        return AppColors.primaryGreen;
      case TripStatusEnum.DECLINED:
      case TripStatusEnum.CANCEL:
      case TripStatusEnum.FAILED:
      case TripStatusEnum.AIRFAILED:
      case TripStatusEnum.HOTELFAILED:
        return AppColors.error;
      case TripStatusEnum.PARTIALLYBOOKED:
      case TripStatusEnum.PARTIALCANCELLED:
        return Colors.grey;
      case TripStatusEnum.SENDFORRECONSIDERATION:
      case TripStatusEnum.TIMEOUT:
      case TripStatusEnum.FAVOURITE:
        return AppColors.primaryTextSwatch[400]!;
    }
  }

  IconData _getStatusIcon(TripStatusEnum status) {
    switch (status) {
      case TripStatusEnum.NEW:
        return Icons.fiber_new;
      case TripStatusEnum.DRAFT:
        return Icons.edit_note;
      case TripStatusEnum.PENDING:
      case TripStatusEnum.APPROVALINITIATED:
      case TripStatusEnum.SUBMITTED:
      case TripStatusEnum.PENDINGAIR:
      case TripStatusEnum.PENDINGHOTEL:
      case TripStatusEnum.TOTALPENDING:
        return Icons.hourglass_empty;
      case TripStatusEnum.APPROVED:
      case TripStatusEnum.SELFAPPROVED:
        return Icons.check_circle;
      case TripStatusEnum.BOOKED:
        return Icons.flight;
      case TripStatusEnum.COMPLETE:
        return Icons.done_all;
      case TripStatusEnum.PAID:
        return Icons.payment;
      case TripStatusEnum.DECLINED:
      case TripStatusEnum.CANCEL:
        return Icons.cancel;
      case TripStatusEnum.FAILED:
      case TripStatusEnum.AIRFAILED:
      case TripStatusEnum.HOTELFAILED:
        return Icons.error;
      case TripStatusEnum.PARTIALLYBOOKED:
      case TripStatusEnum.PARTIALLYAPPROVED:
        return Icons.pending;
      case TripStatusEnum.PARTIALCANCELLED:
        return Icons.block;
      case TripStatusEnum.SENDFORRECONSIDERATION:
        return Icons.refresh;
      case TripStatusEnum.TIMEOUT:
        return Icons.timer_off;
      case TripStatusEnum.FAVOURITE:
        return Icons.star;
    }
  }
}
