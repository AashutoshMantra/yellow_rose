import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/airline_pill.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_card.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_widget.dart';

String getStopText(AirResponseData airResponseData) {
  if (airResponseData.hopCount > 1) {
    return "${airResponseData.hopCount - 1} Stop";
  }
  return "Direct";
}

class ItineraryDetailCard extends StatelessWidget {
  final AirResponseData airResponseData;
  final FlightSearchClass flightSearchClass;
  final bool isSelected;
  const ItineraryDetailCard(
      {super.key,
      required this.airResponseData,
      required this.flightSearchClass,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primarySuccessSwatch[200] : Colors.white,
        borderRadius: BorderRadius.circular(18.h),
        border: Border.all(color: AppColors.primaryTextSwatch[200]!),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Column(
          children: [
            Row(
              children: [
                AirlinePill(
                    airline: "airline",
                    airlineCode:
                        airResponseData.flightDetailsList[0].carrierName),
                const Spacer(),
                Text(
                  "₹ ${airResponseData.fare.first.totalCost}",
                  style: TextStyles.bodyXLargeBoldStyle()
                      .copyWith(color: AppColors.primary),
                )
              ],
            ),
            FlightDetailWidget(
              sourceFLight: airResponseData.flightDetailsList[0],
              lastFlight: airResponseData.flightDetailsList.last,
              travelDuration: airResponseData.travelDuration,
            ),
            FlightSeachClassAndStopWidget(
                flightSearchClass: flightSearchClass,
                airResponseData: airResponseData),
            SizedBox(
              height: 16.h,
            ),
            Text(
              "Flight No: ${airResponseData.flightDetailsList.map((flight) => "${flight.carrierName} ${flight.flightNumber}").join(", ")}",
              style: TextStyles.bodySmallStyle()
                  .copyWith(color: AppColors.primaryTextSwatch[600]),
            )
          ],
        ),
      ),
    );
  }
}

class FlightSeachClassAndStopWidget extends StatelessWidget {
  const FlightSeachClassAndStopWidget({
    super.key,
    required this.flightSearchClass,
    required this.airResponseData,
  });

  final FlightSearchClass flightSearchClass;
  final AirResponseData airResponseData;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyles.bodySmallMediumStyle()
          .copyWith(color: AppColors.primaryTextSwatch[600]),
      child: Row(
        children: [
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "₹"),
                TextSpan(text: " ${flightSearchClass.text}")
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 7.5.w),
            child: CircleAvatar(
              backgroundColor: AppColors.primaryTextSwatch[600],
              maxRadius: 4,
            ),
          ),
          Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                    child: Icon(
                  Icons.arrow_outward_sharp,
                  size: 14.h,
                  color: AppColors.primaryTextSwatch[600],
                )),
                TextSpan(text: " ${getStopText(airResponseData)}")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
