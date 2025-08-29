import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/common_utils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_resonse.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/hotel_search_detail_widget.dart';

class HotelDetailSummaryWidget extends StatelessWidget {
  final HotelSearch hotelSearch;
  final HotelDetailResponse hotelDetailResponse;
  final HotelSearchResponse hotelSearchResponse;
  const HotelDetailSummaryWidget(
      {super.key,
      required this.hotelSearch,
      required this.hotelDetailResponse,
      required this.hotelSearchResponse});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.primarySwatch[300]!,
          width: 1,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HotelUserRating(
              reviewDetails: hotelSearchResponse.reviewDetails,
            ),
            SizedBox(height: 8.h),
            Text(
              "Travel Dates & Guests",
              style: TextStyles.bodyMediumSemiBoldStyle(),
            ),
            SizedBox(height: 5.h),
            // if (hotelDetailResponse.hotel?.checkIn != null &&
            //     hotelDetailResponse.hotel?.checkOut != null)
            Row(
              children: [
                Text("Check-in: ${hotelDetailResponse.hotel?.checkIn}"),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Icon(Icons.arrow_forward, size: 16.h),
                ),
                Text("Check-out: ${hotelDetailResponse.hotel?.checkOut}"),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85.h),
                    color: AppColors.primarySwatch[100],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.1, vertical: 4.h),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_month),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                            "${CustomDateUtils.givenFormat(hotelSearch.checkInDate!, "d MMM")} - ${CustomDateUtils.givenFormat(hotelSearch.checkOutDate!, "d MMM")}")
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(85.h),
                    color: AppColors.primarySwatch[100],
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.1, vertical: 4.h),
                    child: Row(
                      children: [
                        const Icon(Icons.person_pin_outlined),
                        SizedBox(
                          width: 8.w,
                        ),
                        Text(
                            "${(hotelSearch.adultCount!) + (hotelSearch.childAges?.length ?? 0)} Guest / ${hotelSearch.roomCount!} Room")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primarySwatch[100],
              ),
              child: ListTile(
                dense: true,
                onTap: () {
                  Utils.launchMap(hotelDetailResponse.hotel!.latitude!,
                      hotelDetailResponse.hotel!.longitude!);
                },
                contentPadding: EdgeInsets.only(left: 2.h),
                leading: Container(
                  height: double.infinity,
                  width: 40.h,
                  decoration: BoxDecoration(
                      color: AppColors.primarySwatch[100],
                      borderRadius: BorderRadius.circular(8.h)),
                  child: const Icon(
                    Icons.location_pin,
                    color: AppColors.primary,
                  ),
                ),
                title: Text(
                  hotelDetailResponse.hotel?.address ?? '',
                  style: TextStyles.bodyMediumBoldStyle(),
                ),
                trailing: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
