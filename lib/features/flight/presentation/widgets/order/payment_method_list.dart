import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/payment_medium_request_res.dart';

class FlightPaymentMethodListWidget extends StatelessWidget {
  final List<PaymentMediumStatus> paymentMediumStatusList;
  final Function(PaymentMediumStatus paymentMedium) onPaymentMethodSelected;
  const FlightPaymentMethodListWidget({
    super.key,
    required this.paymentMediumStatusList,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primaryTextSwatch[200]!)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  "Payment Methods",
                  textAlign: TextAlign.center,
                  style: TextStyles.bodyXLargeMediumStyle(),
                ),
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          Divider(
            height: 32.h,
            color: AppColors.primaryTextSwatch[200],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                ...(paymentMediumStatusList).map((paymentMedium) {
                  return GestureDetector(
                    onTap: () {
                      onPaymentMethodSelected(paymentMedium);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primaryTextSwatch[200]!,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryTextSwatch[100],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: ImageIcon(
                                const AssetImage(
                                    "assets/images/icons/ewallet.png"),
                                size: 24.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  paymentMedium.mediumName ?? "Unknown",
                                  style: TextStyles.bodySmallBoldStyle(),
                                ),
                                SizedBox(height: 6.h),
                                if (paymentMedium.mediumName == "DEPOSIT" ||
                                    paymentMedium.mediumName == "CREDIT")
                                  Text(
                                    "The cost of this ticket will be charged to your company account maintained with us.",
                                    style: TextStyles.bodySmallMediumStyle()
                                        .copyWith(
                                      color: AppColors.primaryTextSwatch[500]!,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 16.h, color: AppColors.primaryText),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 64.h),
        ],
      ),
    );
  }
}
