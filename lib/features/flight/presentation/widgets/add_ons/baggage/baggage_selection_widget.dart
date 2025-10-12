import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';

class BaggageSelectionWidget extends StatelessWidget {
  final List<PassengerDetailsEntity> passengerDetails;
  final Map<String, SsrOption> selectedBaggage;
  final SsrResponse? ssrs;
  final Function(String, SsrOption?) onBaggageSelect;

  const BaggageSelectionWidget(
      {super.key,
      required this.passengerDetails,
      required this.selectedBaggage,
      this.ssrs,
      required this.onBaggageSelect});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.primarySwatch[200]!,
            ),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryTextSwatch[50]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Baggage Preference",
              style: TextStyles.h6Style().copyWith(color: AppColors.primary),
            ),
            SizedBox(height: 8.h),
            Text(
              "Select additional baggage for your travelers",
              style: TextStyles.bodySmallStyle().copyWith(
                color: AppColors.primaryTextSwatch[600],
              ),
            ),
            SizedBox(height: 16.h),
            ...passengerDetails
                .where((d) => !d.passengerType.isInfant())
                .map((passenger) {
              return Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.luggage,
                      color: AppColors.primaryGreen,
                    ),
                    title: Text(
                      "${passenger.title.name} ${passenger.name} ${passenger.lastName}",
                      style: TextStyles.bodyLargeSemiBoldStyle(),
                    ),
                    trailing: Text(
                        passenger.passengerType.getDescription().toTitleCase(),
                        style: TextStyles.bodySmallSemiBoldStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500])),
                  ),
                  CustomDropDownField(
                    key: ValueKey("${passenger.id}_baggage"),
                    hint: "Select baggage preference",
                    data1: [
                      const DropdownMenuItem<String>(
                        value: null,
                        child: Text("No additional baggage"),
                      ),
                      ...ssrs?.ssrBaggage.map((ssr) {
                            return DropdownMenuItem<String>(
                              value: ssr.code,
                              child: Text(
                                  "${ssr.description ?? ssr.code} - ₹${ssr.totalCost.toStringAsFixed(0)}"),
                            );
                          }).toList() ??
                          [],
                    ],
                    val: selectedBaggage[passenger.id]?.code,
                    onchange: (ssrCode) {
                      var ssr = ssrs?.ssrBaggage
                          .firstWhereOrNull((d) => d.code == ssrCode);

                      onBaggageSelect(passenger.id, ssr);
                    },
                  ),
                  SizedBox(height: 12.h),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
