import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/presentation/widgets/trip_detail/trip_service_card.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';

class TripCartList extends StatelessWidget {
  final TripResponse trip;
  final Map<String, OrderStatus> orderDetails;
  final bool isTeamTrip;
  final Function(SupportedService) onModifyService;

  const TripCartList({
    super.key,
    required this.trip,
    required this.orderDetails,
    required this.isTeamTrip,
    required this.onModifyService,
  });

  @override
  Widget build(BuildContext context) {
    final tripItems = trip.tripItemList ?? [];

    if (tripItems.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tripItems.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) {
        final item = tripItems[index];
        final order = item.cartId != null ? orderDetails[item.cartId!] : null;

        if (order == null) {
          return const SizedBox.shrink();
        }

        return TripServiceCard(
          item: item,
          order: order,
          trip: trip,
          isTeamTrip: isTeamTrip,
          onModify: onModifyService,
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Column(
          children: [
            Icon(
              Icons.luggage_outlined,
              size: 64.h,
              color: AppColors.primaryTextSwatch[300],
            ),
            SizedBox(height: 16.h),
            Text(
              'No services in this trip',
              style: TextStyles.bodyLargeBoldStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
