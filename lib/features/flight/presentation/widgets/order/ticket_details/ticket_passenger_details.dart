import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';

class AirTicketPassengerDetails extends StatelessWidget {
  final OrdersPassengersDetails passengersDetails;
  final int passengerIndex;
  const AirTicketPassengerDetails(
      {super.key,
      required this.passengersDetails,
      required this.passengerIndex});

  Widget getTitleSubtitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: TextStyles.bodySmallSemiBoldStyle()
              .copyWith(color: AppColors.primaryTextSwatch[500]),
        ),
        SizedBox(height: 2.h),
        Text(subtitle, style: TextStyles.bodyMediumBoldStyle()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.h),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryTextSwatch[200]!,
          ),
          borderRadius: BorderRadius.circular(12.h),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
              color: passengersDetails.pnrStatus == "HX" ||
                      passengersDetails.pnrStatus == null
                  ? AppColors.error
                  : AppColors.primaryGreen,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Passenger ${passengerIndex + 1}",
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: Colors.white),
                  ),
                  if (passengersDetails.pnrStatus == "HX")
                    Text(
                      "Cancelled",
                      style: TextStyles.bodySmallMediumStyle()
                          .copyWith(color: Colors.white),
                    ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  getTitleSubtitle("Name",
                      "${passengersDetails.title ?? ''} ${passengersDetails.firstName ?? ""} ${passengersDetails.lastName ?? ""}"),
                  getTitleSubtitle(
                      "Passenger Type",
                      passengersDetails.passengerType?.description
                              .toTitleCase() ??
                          ""),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
