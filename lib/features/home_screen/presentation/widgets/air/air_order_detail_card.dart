import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_order_iitinerary.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_ticket_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_card_header.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_fare_summary.dart';

class AirOrderDetailCard extends StatelessWidget {
  final OrderStatus orderStatus;
  final String? customButtonText;
  final VoidCallback? onCustomButtonPressed;
  final bool readonly;

  const AirOrderDetailCard({
    super.key,
    required this.orderStatus,
    this.customButtonText,
    this.onCustomButtonPressed,
    this.readonly = false,
  });
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
              itinarary.flightDetails!.flightDetailsList.first.schDepartureTime,
              "dd MMM yyyy"),
          style: TextStyles.bodySmallSemiBoldStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingDate = orderStatus.bookingTs ?? orderStatus.creationTs;
    final currencyLabel = _resolveCurrency(orderStatus);
    final fare = _resolveFare(orderStatus);

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.primaryTextSwatch[200]!),
          borderRadius: BorderRadius.circular(18)),
      child: Column(
        children: [
          OrderCardHeader(
            cartId: orderStatus.uuid,
            bookingDate: bookingDate,
            statusText: orderStatus.status?.displayText,
            statusColor: orderStatus.status?.color,
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
                if (fare != null)
                  OrderFareSummary(
                    title: 'Total amount',
                    amountText: formatOrderAmount(fare, currencyLabel),
                    subtitle: '${currencyLabel.toUpperCase()} • Taxes included',
                  ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (customButtonText != null &&
                        onCustomButtonPressed != null)
                      CustomButton(
                        text: customButtonText!,
                        onPressed: onCustomButtonPressed!,
                      )
                    else
                      CustomButton(
                        text: "View booking",
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            FlightTicketScreen.routeName,
                            arguments: {
                              'orderStatus': orderStatus,
                              'readonly': readonly,
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

  String _resolveCurrency(OrderStatus status) {
    final fare = status.airItineraries?.firstOrNull?.flightDetails?.fare;
    final miscellaneousCurrency =
        fare?.firstOrNull?.miscellaneousData?['currency']?.toString().trim();
    if (miscellaneousCurrency != null && miscellaneousCurrency.isNotEmpty) {
      return miscellaneousCurrency;
    }
    return 'INR';
  }

  double? _resolveFare(OrderStatus status) {
    final primary = status.airItineraries?.firstOrNull;
    if (primary == null) return null;

    double aggregate = status.airItineraries!.fold(
        0.0,
        (prev, crr) =>
            (prev ?? 0) +
            (crr.customerPayment?.totalBookingAmount.toDouble() ?? 0.0));
    if ((aggregate ?? 0) <= 0) {
      for (final OrdersPassengersDetails pax in primary.orderPassengerDetails) {
        final bookingClasses = pax.fareDetails?.passengerBookingClasses;
        if (bookingClasses == null || bookingClasses.isEmpty) continue;
        final fareDetails = bookingClasses.first.fareDetailsPerPassengerType;
        aggregate += fareDetails.baseFare + fareDetails.finalTax;
      }
    }
    return aggregate == 0 ? null : aggregate;
  }
}
