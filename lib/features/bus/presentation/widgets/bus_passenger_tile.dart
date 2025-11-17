import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';

class BusPassengerTile extends StatelessWidget {
  final PassengerDetailsEntity passenger;
  final String? seatLabel;

  const BusPassengerTile({
    super.key,
    required this.passenger,
    this.seatLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.w,
              backgroundColor: AppColors.primaryGreen,
              child: Icon(Icons.person, color: Colors.white, size: 18.h),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${passenger.name} ${passenger.lastName}',
                    style: TextStyles.bodyMediumSemiBoldStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[700]),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${passenger.gender.name} • ${passenger.email}',
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[500]),
                  ),
                  Text(
                    passenger.phoneNumber,
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[500]),
                  ),
                  if (seatLabel != null && seatLabel!.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 6.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.w),
                        color: AppColors.primarySwatch[50],
                      ),
                      child: Text('Seat $seatLabel',
                          style: TextStyles.bodySmallBoldStyle()),
                    )
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 12.h),
        Divider(color: AppColors.primaryTextSwatch[100]),
      ],
    );
  }
}
