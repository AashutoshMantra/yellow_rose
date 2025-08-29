import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/custom_list_tile.dart';
import 'package:yellow_rose/core/common_widgets/increment_box.dart';
import 'package:yellow_rose/core/common_widgets/increment_box_pax_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';

class TravelerClassSelectionScreen extends StatefulWidget {
  final int adultCount;
  final int childCount;
  final int infantCount;
  final FlightSearchClass searchClass;

  const TravelerClassSelectionScreen(
      {super.key,
      required this.adultCount,
      required this.childCount,
      required this.infantCount,
      required this.searchClass});

  @override
  State<TravelerClassSelectionScreen> createState() =>
      _TravelerClassSelectionScreenState();
}

class _TravelerClassSelectionScreenState
    extends State<TravelerClassSelectionScreen> {
  int _adultCount = 0;
  int _childCount = 0;
  int _infantCount = 0;
  FlightSearchClass _flightSearchClass = FlightSearchClass.Economy;
  @override
  void initState() {
    super.initState();
    _adultCount = widget.adultCount;
    _childCount = widget.childCount;
    _infantCount = widget.infantCount;
    _flightSearchClass = widget.searchClass;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600.h,
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Traveler",
                  style: TextStyles.bodyLargeBoldStyle(),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop((
                      widget.adultCount,
                      widget.childCount,
                      widget.infantCount,
                      widget.searchClass
                    ));
                  },
                  child: const Icon(
                    Icons.close,
                    color: AppColors.primaryText,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 12.h,
            ),
            Divider(
              color: AppColors.primaryTextSwatch[500],
              thickness: .5,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Add Number of Travelers",
              style: TextStyles.bodyMediumSemiBoldStyle()
                  .copyWith(color: AppColors.primaryTextSwatch[500]),
            ),
            SizedBox(
              height: 19.h,
            ),
            IncrementBoxPaxWidget(
              title: "Adults",
              subtitle: "12 yrs & above",
              onChange: (value) {
                setState(() {
                  _adultCount = value;
                });
              },
              initialValue: widget.adultCount,
              minValue: 1,
            ),
            IncrementBoxPaxWidget(
                title: "Children",
                subtitle: "2 - 12 yrs",
                onChange: (value) {
                  setState(() {
                    _childCount = value;
                  });
                },
                initialValue: widget.childCount),
            IncrementBoxPaxWidget(
                title: "Infants",
                subtitle: "Under 2 yrs",
                onChange: (value) {
                  setState(() {
                    _infantCount = value;
                  });
                },
                initialValue: widget.infantCount,
                maxValue: _adultCount),
            SizedBox(
              height: 20.h,
            ),
            Text(
              "Class",
              style: TextStyles.bodyLargeBoldStyle(),
            ),
            SizedBox(
              height: 4.h,
            ),
            Divider(
              color: AppColors.primaryTextSwatch[500],
              thickness: .5,
            ),
            SizedBox(
              height: 4.h,
            ),
            Text(
              "Choose Cabin",
              style: TextStyles.bodyMediumSemiBoldStyle()
                  .copyWith(color: AppColors.primaryTextSwatch[500]),
            ),
            SizedBox(
              height: 15.h,
            ),
            Wrap(
              spacing: 12,
              runSpacing: 10,
              children: FlightSearchClass.values.mapIndexed((idx, searchClass) {
                var isSelected = _flightSearchClass == searchClass;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _flightSearchClass = searchClass;
                    });
                  },
                  child: Card(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: AppColors.primaryTextSwatch[500]!),
                          color:
                              isSelected ? AppColors.primarySwatch[400] : null),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 5.h, horizontal: 12.w),
                        child: Text(
                          searchClass.text,
                          style: TextStyles.bodyLargeSemiBoldStyle().copyWith(
                              color: isSelected ? Colors.white : null),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 28.h,
            ),
            CustomButton(
              text: "Save",
              onPressed: () {
                Navigator.of(context).pop((
                  _adultCount,
                  _childCount,
                  _infantCount,
                  _flightSearchClass
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
