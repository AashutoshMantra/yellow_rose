import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_ticket_screen.dart';

class AirOrderDetailCard extends StatelessWidget {
  final OrderStatus orderStatus;
  const AirOrderDetailCard({super.key, required this.orderStatus});
  Widget getSourceDestinationWidget(AirOrderItinerary itinarary) {
    var source = itinarary.flightDetails!.flightDetailsList.first.fromAirport;
    var destination = itinarary.flightDetails!.flightDetailsList.last.toAirport;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "$source -> $destination",
          style: TextStyles.bodyMediumBoldStyle(),
        ),
        Text(
          CustomDateUtils.givenFormat(
              itinarary.flightDetails!.flightDetailsList.first
                      .schDepartureTime ??
                  DateTime.now(),
              "dd MMM yyyy"),
          style: TextStyles.bodySmallSemiBoldStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primaryTextSwatch[200]!),
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: "Cart ID: ",
                      style: TextStyles.bodySmallMediumStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                      children: [
                        TextSpan(
                          text: orderStatus.uuid ?? '',
                          style: TextStyles.bodySmallBoldStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Pill(
                  backgroundColor: orderStatus.status?.color,
                  child: Text(
                    orderStatus.status?.displayText ?? '',
                    style: TextStyles.bodyMediumSemiBoldStyle()
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 10.h,
            color: AppColors.primarySwatch[200],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, idx) {
                      return getSourceDestinationWidget(
                          orderStatus.airItineraries![idx]);
                    },
                    separatorBuilder: (ctx, idx) {
                      return Divider(
                        height: 18.h,
                        color: AppColors.primarySwatch[200],
                      );
                    },
                    itemCount: orderStatus.airItineraries?.length ?? 0),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomButton(
                      text: "E-Ticket",
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          FlightTicketScreen.routeName,
                          arguments: {
                            'orderStatus': orderStatus,
                          },
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
