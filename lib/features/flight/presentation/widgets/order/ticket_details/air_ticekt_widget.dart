import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_order_modify_screen.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/airline_pill.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_card.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/itineray_detail_card.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/order/ticket_details/ticket_passenger_details.dart';

class AirTicektWidget extends StatelessWidget {
  final AirOrderItinerary airOrderItinerary;
  final OrderStatus? orderStatus;
  final String orderId;
  const AirTicektWidget(
      {super.key,
      required this.airOrderItinerary,
      this.orderStatus,
      required this.orderId});

  @override
  Widget build(BuildContext context) {
    var filteredPassengers = airOrderItinerary.orderPassengerDetails
        .where((element) =>
            element.pnrStatus != null &&
            element.pnrStatus!.toLowerCase() !=
                CANCELLED_PASSENGER_PNR_STATUS.toLowerCase())
        .toList();
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.primaryTextSwatch[200]!,
        ),
        borderRadius: BorderRadius.circular(8.h),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            AirTicektFlightDetails(
              airOrderItinerary: airOrderItinerary,
              orderStatus: orderStatus,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              child: DottedLine(
                alignment: WrapAlignment.center,
                dashColor: AppColors.primarySwatch[400]!,
              ),
            ),
            ListView.separated(
              itemBuilder: (ctx, idx) {
                var passengerDetails =
                    airOrderItinerary.orderPassengerDetails[idx];
                return AirTicketPassengerDetails(
                  passengersDetails: passengerDetails,
                  passengerIndex: idx,
                );
              },
              separatorBuilder: (ctx, idx) {
                return SizedBox(height: 8.h);
              },
              itemCount: airOrderItinerary.orderPassengerDetails.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
            SizedBox(height: 16.h),
            if (filteredPassengers.isNotEmpty)
              CustomButton(
                  text: "Modify Booking",
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        FlightOrderModifyScreen.routeName,
                        arguments: {
                          'orderStatus': orderStatus,
                          'airOrderItinerary': airOrderItinerary,
                          'orderId': orderId,
                        });
                  })
          ],
        ),
      ),
    );
  }
}

class AirTicektFlightDetails extends StatelessWidget {
  final AirOrderItinerary airOrderItinerary;
  final OrderStatus? orderStatus;
  const AirTicektFlightDetails(
      {super.key, required this.airOrderItinerary, this.orderStatus});

  @override
  Widget build(BuildContext context) {
    var sourceFLight =
        airOrderItinerary.flightDetails!.flightDetailsList.firstOrNull;
    var destinationFLight =
        airOrderItinerary.flightDetails!.flightDetailsList.lastOrNull;
    var firstPassenger = airOrderItinerary.orderPassengerDetails.firstOrNull;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              AirlinePill(
                  airline: "airline",
                  airlineCode: sourceFLight?.carrierName ?? ''),
              const Spacer(),
              Pill(
                backgroundColor: orderStatus?.status?.color,
                child: Text(
                  orderStatus?.status?.displayText ?? '',
                  style: TextStyles.bodyMediumSemiBoldStyle()
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                sourceFLight!.fromAirport,
                style: TextStyles.bodyMediumBoldStyle(),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_right_alt,
                size: 22.h,
                color: AppColors.primaryText,
              ),
              SizedBox(width: 8.w),
              Text(
                destinationFLight!.toAirport,
                style: TextStyles.bodyMediumBoldStyle(),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                CustomDateUtils.givenFormat(
                    sourceFLight.schDepartureTime ?? DateTime.now(),
                    "HH:mm, dd MMM yyyy"),
                style: TextStyles.bodySmallMediumStyle().copyWith(
                  color: AppColors.primaryTextSwatch[600],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_right_alt,
                size: 16.h,
                color: AppColors.primaryTextSwatch[600],
              ),
              SizedBox(width: 8.w),
              Text(
                CustomDateUtils.givenFormat(
                    destinationFLight.schArrivalTime ?? DateTime.now(),
                    "HH:mm, dd MMM yyyy"),
                style: TextStyles.bodySmallMediumStyle().copyWith(
                  color: AppColors.primaryTextSwatch[600],
                ),
              ),
            ],
          ),
          if (orderStatus != null) SizedBox(height: 8.h),
          if (orderStatus != null)
            FlightSeachClassAndStopWidget(
                flightSearchClass: orderStatus
                        ?.searchRequest
                        ?.airSearchRequestBaseDetails
                        ?.firstOrNull
                        ?.requestedClass
                        ?.getRequestedClass() ??
                    FlightSearchClass.Economy,
                airResponseData: airOrderItinerary.flightDetails!),
          SizedBox(height: 8.h),
          Row(
            children: [
              Text(
                "PNR",
                style: TextStyles.bodySmallMediumStyle().copyWith(
                  color: AppColors.primaryTextSwatch[600],
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_right_alt,
                size: 22.h,
                color: AppColors.primaryText,
              ),
              SizedBox(width: 8.w),
              Text(
                firstPassenger?.providerPnr ?? firstPassenger?.pnr ?? "",
                style: TextStyles.bodySmallBoldStyle(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
