import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/ImageIcon.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/booking_class.dart';

class FareInfoWidget extends StatelessWidget {
  final bool isSelected;
  final Function(FareDetailsWithType) onSelect;
  final FareDetailsWithType fareDetail;
  const FareInfoWidget({
    super.key,
    required this.fareDetail,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelect(fareDetail);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(10)),
        child: Container(
          child: Column(
            children: [
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                value: isSelected,
                onChanged: (value) {
                  onSelect(fareDetail);
                },
                title: Text(
                  fareDetail.fareTypeDisplay ??
                      fareDetail.fareType ??
                      "Published",
                  style: TextStyles.bodyLargeSemiBoldStyle().copyWith(
                    color: AppColors.primaryTextSwatch[700],
                  ),
                ),
                secondary: Text(
                  "₹ ${fareDetail.baseFare + fareDetail.finalTax}",
                  style: TextStyles.bodyXLargeBoldStyle().copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              ListTile(
                leading: const CustomImageIcon(
                    image: AssetImage("assets/images/icons/bag.png"),
                    color: AppColors.primary),
                title: Text(
                  "Cabin bag",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                trailing: Text(
                  "7 Kg",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
              ),
              ListTile(
                leading: const CustomImageIcon(
                    image: AssetImage("assets/images/icons/canel_flight.png"),
                    color: AppColors.primary),
                title: Text(
                  "Cancellation",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                trailing: Text(
                  fareDetail.refundable ? "Refundable" : "Chargeable",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
              ),
              ListTile(
                leading: const CustomImageIcon(
                    image: AssetImage("assets/images/icons/meal.png"),
                    color: AppColors.primary),
                title: Text(
                  "Cancellation",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                trailing: Text(
                  fareDetail.hasFreeMeal ? "Free Meal" : "Chargeable",
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
