import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';

class FlightRecentSearchCard extends StatelessWidget {
  final AirSearch recentSearch;
  const FlightRecentSearchCard({super.key, required this.recentSearch});

  Widget getSourceDestinationWidget(SourceDestinationDatePair source) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "${source.source!.city} (${source.source!.iataCode}) -> ${source.destination!.city} (${source.destination!.iataCode})",
          style: TextStyles.bodyMediumBoldStyle(),
        ),
        Text(
          "${CustomDateUtils.givenFormat(source.sourceDate ?? DateTime.now(), "dd MMM yyyy")}${source.returnDate != null ? " -> ${CustomDateUtils.givenFormat(source.returnDate!, "dd MMM yyyy")}" : ''}",
          style: TextStyles.bodySmallMediumStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var mappedToWidget =
        recentSearch.sources.map(getSourceDestinationWidget).toList();

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.primaryTextSwatch[200]!),
          borderRadius: BorderRadius.circular(8)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 145.h),
        child: Container(
          padding: EdgeInsets.all(16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...mappedToWidget,
              Row(
                children: [
                  Text(
                    recentSearch.searchClass?.text ?? "",
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  if (recentSearch.searchClass != null)
                    Text(
                      "•",
                      style: TextStyles.bodySmallMediumStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                    ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outlined,
                        color: AppColors.primaryTextSwatch[600],
                        size: 14.h,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        "${recentSearch.childCount + recentSearch.infantCount + recentSearch.adultCount} pax",
                        style: TextStyles.bodySmallMediumStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[600]),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
