import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';

class MealSelectionWidget extends StatelessWidget {
  final List<PassengerDetailsEntity> passengerDetails;
  final Map<String, SsrOption> selectedSsr;
  final SsrResponse? ssrs;
  final Function(String, SsrOption) onMealSelect;

  const MealSelectionWidget(
      {super.key,
      required this.passengerDetails,
      required this.selectedSsr,
      this.ssrs,
      required this.onMealSelect});

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
              "Traveler Meals",
              style: TextStyles.h6Style().copyWith(color: AppColors.primary),
            ),
            ...passengerDetails
                .where((d) => !d.passengerType.isInfant())
                .map((passenger) {
              return Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(
                      Icons.account_circle,
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
                    key: ValueKey(passenger.id),
                    data1: ssrs?.ssrMeals.map((ssr) {
                          return DropdownMenuItem<String>(
                            value: ssr.code,
                            child:
                                Text("${ssr.type} (${ssr.description ?? ''})"),
                          );
                        }).toList() ??
                        [],
                    val: selectedSsr[passenger.id]?.code,
                    onchange: (ssrCode) {
                      var ssr =
                          ssrs?.ssrMeals.firstWhere((d) => d.code == ssrCode);
                      onMealSelect(passenger.id, ssr!);
                    },
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
