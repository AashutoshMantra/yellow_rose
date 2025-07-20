import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/pill.dart';
import 'package:yellow_rose/core/constants/airline_code.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

class AirlinePill extends StatelessWidget {
  final String airline;
  final String airlineCode;
  const AirlinePill(
      {super.key, required this.airline, required this.airlineCode});

  @override
  Widget build(BuildContext context) {
    return Pill(
        child: Row(
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://airlines-images.s3.ap-south-1.amazonaws.com/$airlineCode.png",
          height: 17.h,
          width: 17.h,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => ImageIcon(
            const AssetImage("assets/images/icons/air.png"),
            size: 17.h,
          ),
          
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          carrierCodeNameMap[airlineCode] ?? airline,
          style: TextStyles.bodySmallMediumStyle()
              .copyWith(color: AppColors.primaryTextSwatch[700]),
        )
      ],
    ));
  }
}
