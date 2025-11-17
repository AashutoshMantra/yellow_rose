import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

String orderCurrencySymbol(String currency) {
  switch (currency.toUpperCase()) {
    case 'INR':
      return '₹';
    case 'USD':
      return r'$';
    case 'EUR':
      return '€';
    case 'GBP':
      return '£';
    case 'SGD':
      return r'S$';
    case 'AED':
      return 'د.إ';
    default:
      return currency.toUpperCase();
  }
}

String formatOrderAmount(double? amount, String currency) {
  if (amount == null) return 'Amount unavailable';
  return '${orderCurrencySymbol(currency)} ${amount.toStringAsFixed(2)}';
}

class OrderFareSummary extends StatelessWidget {
  final String title;
  final String amountText;
  final String? subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  const OrderFareSummary({
    super.key,
    required this.title,
    required this.amountText,
    this.subtitle,
    this.trailing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primarySwatch[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyles.bodySmallSemiBoldStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                SizedBox(height: 4.h),
                Text(
                  amountText,
                  style: TextStyles.bodyLargeBoldStyle(),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: 2.h),
                  Text(
                    subtitle!,
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: 12.w),
            trailing!,
          ]
        ],
      ),
    );
  }
}
