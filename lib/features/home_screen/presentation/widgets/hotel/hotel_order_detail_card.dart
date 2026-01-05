import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';
import 'package:yellow_rose/features/hotel/presentation/pages/hotel_booking_detail_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_card_header.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_fare_summary.dart';

String formatBookingDate(DateTime? d) {
  if (d == null) return '-';
  return CustomDateUtils.givenFormat(d, 'dd MMM yyyy');
}

class HotelOrderDetailCard extends StatelessWidget {
  final OrderStatus orderStatus;
  final String? customButtonText;
  final VoidCallback? onCustomButtonPressed;
  final bool readonly;

  const HotelOrderDetailCard({
    super.key,
    required this.orderStatus,
    this.customButtonText,
    this.onCustomButtonPressed,
    this.readonly = false,
  });

  int _computeNights(DateTime? a, DateTime? b) {
    try {
      if (a == null || b == null) return 0;
      return b.difference(a).inDays;
    } catch (_) {
      return 0;
    }
  }

  int _guestCount() {
    final travellerCount = orderStatus.hotelBooking?.travellerDetails;
    if (travellerCount != null) {
      return travellerCount.adult +
          travellerCount.child +
          travellerCount.infantCount;
    }
    final listCount =
        orderStatus.hotelBooking?.hotelBookingRequest?.travellers?.length;
    if (listCount != null) return listCount;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final hotelDetail = orderStatus.hotelBooking?.selectedHotelOrder?.hotel;
    final hotelSearch = orderStatus.hotelBooking?.hotelRequest;

    final hotelName = hotelDetail?.name ?? 'Hotel';
    final hotelAddress = hotelDetail?.address ?? '-';
    final checkIn = hotelSearch?.checkInDate;
    final checkOut = hotelSearch?.checkOutDate;
    final nights = _computeNights(checkIn, checkOut);
    final guests = _guestCount();
    final bookingDate = orderStatus.bookingTs ?? orderStatus.creationTs;
    final currencyLabel =
        orderStatus.hotelBooking?.hotelBookingRequest?.currency ?? 'INR';
    final totalPaid = orderStatus.hotelBooking?.payment?.amount;

    final imageUrl = hotelDetail != null
        ? (hotelDetail.mmtMedia != null && hotelDetail.mmtMedia!.isNotEmpty
            ? hotelDetail.mmtMedia!.first
            : (hotelDetail.agodaMedia != null &&
                    hotelDetail.agodaMedia!.isNotEmpty
                ? hotelDetail.agodaMedia!.first
                : null))
        : null;

    final resolvedImageUrl = HotelMapperUtiity.getImageUrl(imageUrl);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primaryTextSwatch[200]!),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          OrderCardHeader(
            cartId: orderStatus.uuid,
            bookingDate: bookingDate,
            statusText: orderStatus.status?.displayText,
            statusColor: orderStatus.status?.color,
          ),
          Divider(height: 10.h, color: AppColors.primarySwatch[200]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image

                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 84.w,
                    height: 84.w,
                    color: AppColors.primaryTextSwatch[50],
                    child:
                        resolvedImageUrl != null && resolvedImageUrl.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: resolvedImageUrl,
                                fit: BoxFit.cover,
                                placeholder: (_, __) => Center(
                                    child: SizedBox(
                                        width: 24.w,
                                        height: 24.w,
                                        child: const CircularProgressIndicator(
                                          strokeWidth: 2.0,
                                          color: AppColors.primary,
                                        ))),
                                errorWidget: (_, __, ___) => Icon(Icons.hotel,
                                    color: AppColors.primaryTextSwatch[300]),
                              )
                            : Icon(Icons.hotel,
                                size: 36.w,
                                color: AppColors.primaryTextSwatch[300]),
                  ),
                ),
                SizedBox(width: 12.w),
                // Name & address
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotelName, style: TextStyles.bodyMediumBoldStyle()),
                      SizedBox(height: 6.h),
                      Text(
                        hotelAddress,
                        style: TextStyles.bodySmallSemiBoldStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[600]),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${formatBookingDate(checkIn)}  •  ${formatBookingDate(checkOut)}',
                        style: TextStyles.bodySmallMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[400]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.people,
                        size: 18.w, color: AppColors.primaryTextSwatch[600]),
                    SizedBox(width: 6.w),
                    Text(
                      '$guests Guests',
                      style: TextStyles.bodySmallMediumStyle(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.nights_stay,
                        size: 18.w, color: AppColors.primaryTextSwatch[600]),
                    SizedBox(width: 6.w),
                    Text(
                      '$nights Nights',
                      style: TextStyles.bodySmallMediumStyle(),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (totalPaid != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
              child: OrderFareSummary(
                title: 'Total paid',
                amountText: formatOrderAmount(totalPaid, currencyLabel),
                subtitle: '${currencyLabel.toUpperCase()} • Taxes included',
              ),
            ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 18.h),
            child: customButtonText != null && onCustomButtonPressed != null
                ? CustomButton(
                    text: customButtonText!,
                    onPressed: onCustomButtonPressed!,
                  )
                : CustomButton(
                    text: 'View booking',
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        HotelBookingDetailScreen.routeName,
                        arguments: {
                          'orderStatus': orderStatus,
                          'readonly': readonly,
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
