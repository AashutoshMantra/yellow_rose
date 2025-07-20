import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';

class AddonPriceDetails extends StatelessWidget {
  final String title;
  final String subtitle;
  final String rightTitle;
  final String? rightSubtitle;

  const AddonPriceDetails(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.rightTitle,
      this.rightSubtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.primary)),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
      ),
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyles.bodyMediumSemiBoldStyle(),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        subtitle,
                        style: TextStyles.bodySmallSemiBoldStyle()
                            .copyWith(color: AppColors.errorSwatch[500]),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        rightTitle,
                        style: TextStyles.bodyMediumMediumStyle(),
                      ),
                    ),
                    if (rightSubtitle != null)
                      Expanded(
                        child: Text(
                          rightSubtitle!,
                          style: TextStyles.bodySmallSemiBoldStyle()
                              .copyWith(color: AppColors.primarySwatch[300]),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
