import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/image_icon_button.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

class TripServiceSelector extends StatelessWidget {
  final TripResponse trip;
  final Function(SupportedService) onServiceSelected;

  const TripServiceSelector({
    super.key,
    required this.trip,
    required this.onServiceSelected,
  });

  bool _isServiceInTrip(TripResponse trip, SupportedService service) {
    final tripItems = trip.tripItemList ?? [];
    return tripItems.any((item) {
      if (service == SupportedService.Flights) {
        return item.type == ProductTypeEnum.AIR;
      } else if (service == SupportedService.Hotels) {
        return item.type == ProductTypeEnum.HOTEL;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final supportedServices = [
      SupportedService.Flights,
      SupportedService.Hotels
    ];

    final hasServicesToAdd =
        supportedServices.any((s) => !_isServiceInTrip(trip, s));

    if (!hasServicesToAdd) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Services',
          style: TextStyles.bodyLargeBoldStyle(),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: supportedServices.map((supportedService) {
            final isAdded = _isServiceInTrip(trip, supportedService);
            return ImageIconButton(
              onClick:
                  isAdded ? null : () => onServiceSelected(supportedService),
              image: AssetImage(
                  "assets/images/icons/${supportedService.getImagePath()}.png"),
              color: AppColors.icon,
              title: supportedService.name,
            );
          }).toList(),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}
