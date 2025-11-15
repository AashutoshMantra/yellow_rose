import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_search_response.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';

class BusSearchResultCard extends StatelessWidget {
  final BusSearchResponse busSearchResponse;
  final bool isSelected;
  final VoidCallback? onTap;

  const BusSearchResultCard({
    super.key,
    required this.busSearchResponse,
    this.isSelected = false,
    this.onTap,
  });

  String _getBusTypeText(BusSearchResponse busSearchResponse) {
    return busSearchResponse.busType ?? '';
    String type = '';
    if (busSearchResponse.aC == true) {
      type += 'AC ';
    } else {
      type += 'Non-AC ';
    }

    if (busSearchResponse.sleeper == true) {
      type += 'Sleeper';
    } else if (busSearchResponse.seater == true) {
      type += 'Seater';
    } else {
      type += busSearchResponse.busType ?? 'Bus';
    }

    return type;
  }

  String _getSeatsInfo() {
    final availableSeats = busSearchResponse.availableSeats ?? 0;
    return '$availableSeats seats left';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.primarySuccessSwatch[200] : Colors.white,
          borderRadius: BorderRadius.circular(12.h),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.primaryTextSwatch[200]!,
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Operator and Price Row

              Row(
                children: [
                  Pill(
                    child: Text(
                      busSearchResponse.operatorDetails?.operatorName ??
                          'Unknown Operator',
                      style: TextStyles.bodySmallSemiBoldStyle(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '₹${busSearchResponse.fare?.first.totalFare?.toStringAsFixed(0) ?? 'N/A'}',
                    style: TextStyles.bodyXLargeBoldStyle()
                        .copyWith(color: AppColors.primary),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Time and Duration Row
              Row(
                children: [
                  // Departure Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          busSearchResponse.departureTime != null
                              ? CustomDateUtils.timeIn24(
                                  busSearchResponse.departureTime!)
                              : '--:--',
                          style: TextStyles.bodyLargeBoldStyle(),
                        ),
                      ],
                    ),
                  ),

                  // Dashed Line with Duration
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(top: 12.h),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        const DasshedArrowLine(),
                        if (busSearchResponse.duration != null)
                          Positioned(
                            top: 10.h,
                            child: Container(
                              child: Text(
                                busSearchResponse.duration!,
                                style: TextStyles.bodySmallMediumStyle()
                                    .copyWith(
                                        color:
                                            AppColors.primaryTextSwatch[500]),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),

                  // Arrival Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          busSearchResponse.arrivalTime != null
                              ? CustomDateUtils.timeIn24(
                                  busSearchResponse.arrivalTime!)
                              : '--:--',
                          style: TextStyles.bodyLargeBoldStyle(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),

              // Bus Type and Seats Info Row
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bus Type
                  Text(
                    _getBusTypeText(busSearchResponse),
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                  SizedBox(height: 12.h),
                  // Seats Info
                  Row(
                    children: [
                      Text(
                        _getSeatsInfo(),
                        style: TextStyles.bodySmallMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
