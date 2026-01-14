import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/increment_box_pax_widget.dart';
import 'package:yellow_rose/core/common_widgets/custom_banner.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/core/utils/trip_validation_helper.dart';
import 'package:yellow_rose/features/trip/data/models/trip_create_request.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class HotelTravellerCountSelectionWidget extends StatefulWidget {
  final int adultCount;
  final int childCount;
  final int roomCount;
  final List<int> childAges;

  const HotelTravellerCountSelectionWidget(
      {super.key,
      required this.adultCount,
      required this.childCount,
      required this.roomCount,
      required this.childAges});

  @override
  State<HotelTravellerCountSelectionWidget> createState() =>
      _HotelTravellerCountSelectionWidgetState();
}

class _HotelTravellerCountSelectionWidgetState
    extends State<HotelTravellerCountSelectionWidget> {
  int _adultCount = 0;
  int _childCount = 0;
  int _roomCount = 0;
  final List<int?> _childAges = [];
  @override
  void initState() {
    super.initState();
    _adultCount = widget.adultCount;
    _childCount = widget.childCount;
    _roomCount = widget.roomCount;

    _childAges.clear();
    _childAges.addAll(widget.childAges);
  }

  Widget buildChildAgeSelector(int index) {
    return Row(
      children: [
        Expanded(
          child: Text("Child ${index + 1} Age:",
              style: TextStyles.bodyMediumSemiBoldStyle()
                  .copyWith(color: AppColors.primaryText)),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomDropDownField(
            val: _childAges.elementAtOrNull(index)?.toString(),
            data1: List.generate(13, (i) => i).map((age) {
              return DropdownMenuItem<String>(
                value: age.toString(),
                child: Text("$age"),
              );
            }).toList(),
            onchange: (value) {
              if (mounted)
                setState(() {
                  _childAges[index] = int.parse(value ?? '0');
                });
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedTrip = context.read<TripCubit>().selectedTrip;
    final shouldDisableControls =
        TripValidationHelper.shouldDisablePassengerControls(selectedTrip);
    final shouldDisableRooms = selectedTrip?.tripFor == TripFor.Self.value;

    return Container(
      child: Padding(
        padding: EdgeInsets.all(24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Select Rooms and Guests",
                  style: TextStyles.bodyLargeBoldStyle(),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop((
                      widget.adultCount,
                      widget.childCount,
                      widget.roomCount,
                      widget.childAges
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
            // Trip constraint info banner
            if (selectedTrip != null && shouldDisableControls) ...[
              CustomBanner(
                message: selectedTrip.tripFor == TripFor.Self.value
                    ? "Self trip: Only 1 room and 1 adult allowed"
                    : "On Behalf trip: Guest count fixed to ${selectedTrip.tripDetails?.onBehalf?.length ?? 0} passengers as per trip. Maximum $_adultCount rooms allowed.",
                type: BannerType.info,
              ),
            ],
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
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
                  title: "Rooms",
                  subtitle: "",
                  onChange: (value) {
                    if (mounted)
                      setState(() {
                        _roomCount = value;
                      });
                  },
                  initialValue: _roomCount,
                  minValue: 1,
                  maxValue: shouldDisableRooms ? 1 : _adultCount,
                  enabled: !shouldDisableRooms,
                ),
                IncrementBoxPaxWidget(
                  title: "Adults",
                  subtitle: "12 yrs & above",
                  onChange: (value) {
                    if (mounted)
                      setState(() {
                        _adultCount = value;
                      });
                  },
                  initialValue: _adultCount,
                  minValue: 1,
                  enabled: !shouldDisableControls,
                ),
                IncrementBoxPaxWidget(
                    title: "Children",
                    subtitle: "0 - 12 yrs",
                    onChange: (value) {
                      while (value > _childAges.length) {
                        _childAges.add(null);
                      }
                      while (value < _childAges.length) {
                        _childAges.removeLast();
                      }
                      if (mounted)
                        setState(() {
                          _childCount = value;
                        });
                    },
                    initialValue: _childCount,
                    enabled: !shouldDisableControls),
                SizedBox(
                  height: 20.h,
                ),
                if (_childCount > 0)
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primarySwatch[100],
                      borderRadius: BorderRadius.circular(8.h),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Age of Children",
                            style: TextStyles.bodyMediumSemiBoldStyle()
                                .copyWith(
                                    color: AppColors.primaryTextSwatch[500]),
                          ),
                          for (int i = 0; i < _childCount; i++)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: buildChildAgeSelector(i),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            child: Text(
                              "Please provide right number of children along with their right age for best options and prices.",
                              style: TextStyles.bodySmallStyle()
                                  .copyWith(color: AppColors.primaryText),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomButton(
                  text: "Save",
                  onPressed: () {
                    var haveNullAge = _childAges.any((age) => age == null);
                    if (haveNullAge) {
                      WidgetUtil.showSnackBar(
                          "Please Enter Age For Each Child", context);
                      return;
                    }
                    Navigator.of(context).pop(
                        (_adultCount, _childCount, _roomCount, _childAges));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
