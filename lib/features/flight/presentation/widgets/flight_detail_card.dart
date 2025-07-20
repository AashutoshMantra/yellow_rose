import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/dependncy_injection.dart';
import 'package:yellow_rose/features/flight/data/models/airports.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/domain/usecases/air_usecase.dart';
import 'package:yellow_rose/features/flight/presentation/pages/traveller_class_selection_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/airline_pill.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_widget.dart';

class FlightDetailCard extends StatelessWidget {
  final FlightDetailsWIthBookingClass sourceFLight;

  late final Airport? sourceAirport;
  late final Airport? destinationAirport;

  FlightDetailCard({
    super.key,
    required this.sourceFLight,
  }) {
    final airUSeCase = getIt<AirUseCase>();
    sourceAirport = airUSeCase.getAirportByIata(sourceFLight.fromAirport);
    destinationAirport = airUSeCase.getAirportByIata(sourceFLight.toAirport);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryTextSwatch[200]!),
          borderRadius: BorderRadius.circular(18)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
        child: Column(
          children: [
            Row(
              children: [
                AirlinePill(
                    airline: "airline", airlineCode: sourceFLight.carrierName),
                const Spacer(),
                Text(
                  "Flight No: ${sourceFLight.carrierName} ${sourceFLight.flightNumber}",
                  style: TextStyles.bodySmallStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                )
              ],
            ),
            FlightDetailWidget(
                sourceFLight: sourceFLight,
                sourceAirport: sourceAirport,
                lastFlight: sourceFLight,
                destinationAirport: destinationAirport,
                travelDuration: sourceFLight.travelDuration),
          ],
        ),
      ),
    );
  }
}

Column getFLightDetails(FlightDetailsWIthBookingClass sourceFLight, bool useTo,
    {Airport? sourceAirport}) {
  return Column(
    children: [
      if (sourceAirport == null)
        Text(
          useTo ? sourceFLight.toAirport : sourceFLight.fromAirport,
          style: TextStyles.bodyMediumBoldStyle(),
        ),
      Text(
        CustomDateUtils.timeIn24(useTo
            ? sourceFLight.schArrivalTime
            : sourceFLight.schDepartureTime),
        style: sourceAirport != null
            ? TextStyles.bodyMediumBoldStyle()
            : TextStyles.bodySmallStyle()
                .copyWith(color: AppColors.primaryTextSwatch[500]),
      ),
      if (sourceAirport == null)
        Text(
          CustomDateUtils.dayDateMonthYearFormat(useTo
              ? sourceFLight.schArrivalTime
              : sourceFLight.schDepartureTime),
          style: TextStyles.bodySmallStyle()
              .copyWith(color: AppColors.primaryTextSwatch[500]),
        ),
      if (sourceAirport != null)
        SizedBox(
          height: 6.h,
        ),
      if (sourceAirport != null)
        Text(
          sourceAirport.city!,
          textAlign: TextAlign.center,
          style: TextStyles.bodyMediumSemiBoldStyle(),
        ),
      if (sourceAirport != null)
        SizedBox(
          height: 2.h,
        ),
      if (sourceAirport != null)
        Text(
          sourceAirport.name!,
          textAlign: TextAlign.center,
          style: TextStyles.bodySmallStyle()
              .copyWith(color: AppColors.primaryTextSwatch[500]),
        ),
      if ((!useTo && sourceFLight.fromTerminal?.isNotEmpty == true) ||
          (useTo && sourceFLight.toTerminal?.isNotEmpty == true))
        Text(
          "Terminal ${useTo ? sourceFLight.toTerminal : sourceFLight.fromTerminal!}",
          style: TextStyles.bodySmallStyle()
              .copyWith(color: AppColors.primaryTextSwatch[500]),
        ),
    ],
  );
}
