import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_card.dart';

class FlightDetailWidget extends StatelessWidget {
  final FlightDetailsWIthBookingClass sourceFLight;
  final Airport? sourceAirport;
  final Airport? destinationAirport;
  final FlightDetailsWIthBookingClass lastFlight;
  final int? travelDuration;

  const FlightDetailWidget(
      {super.key,
      required this.sourceFLight,
      required this.lastFlight,
      this.travelDuration,
      this.sourceAirport,
      this.destinationAirport});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: getFLightDetails(sourceFLight, false,
                  sourceAirport: sourceAirport)),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(top: 12.h),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                const DasshedArrowLine(),
                if (travelDuration != null)
                  Positioned(
                    top: 10.h,
                    child: Container(
                      child: Text(
                        CustomDateUtils.durationToString(travelDuration!),
                        style: TextStyles.bodySmallMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500]),
                      ),
                    ),
                  )
              ],
            ),
          )),
          Expanded(
              child: getFLightDetails(lastFlight, true,
                  sourceAirport: destinationAirport))
        ],
      ),
    );
  }
}
