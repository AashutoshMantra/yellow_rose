import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class OrderCardHeader extends StatelessWidget {
  final String? cartId;
  final DateTime? bookingDate;
  final String bookingLabel;
  final String? statusText;
  final Color? statusColor;
  final EdgeInsetsGeometry? padding;

  const OrderCardHeader({
    super.key,
    this.cartId,
    this.bookingDate,
    this.bookingLabel = 'Booking',
    this.statusText,
    this.statusColor,
    this.padding,
  });

  String _formatDate(DateTime? value) {
    if (value == null) return '-';
    return CustomDateUtils.givenFormat(value, 'dd MMM yyyy');
  }

  @override
  Widget build(BuildContext context) {
    final effectivePadding =
        padding ?? EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h);

    return Padding(
      padding: effectivePadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Cart ID: ',
                    style: TextStyles.bodySmallMediumStyle().copyWith(
                      color: AppColors.primaryTextSwatch[600],
                    ),
                    children: [
                      TextSpan(
                        text: cartId ?? '-',
                        style: TextStyles.bodySmallBoldStyle(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '$bookingLabel: ${_formatDate(bookingDate)}',
                  style: TextStyles.bodySmallSemiBoldStyle().copyWith(
                    color: AppColors.primaryTextSwatch[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Pill(
            backgroundColor: statusColor ?? AppColors.primary,
            child: Text(
              statusText ?? '',
              style: TextStyles.bodyMediumSemiBoldStyle()
                  .copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
