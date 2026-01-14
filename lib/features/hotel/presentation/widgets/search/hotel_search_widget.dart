import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/date_picker.dart';
import 'package:yellow_rose/core/common_widgets/labeled_info_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';

import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';
import 'package:yellow_rose/features/hotel/domain/entities/hotel_search.dart';
import 'package:yellow_rose/features/hotel/presentation/cubit/search/hotel_search_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/hotel_traveller_count_selection_widget.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';
import 'package:yellow_rose/features/hotel/presentation/widgets/search/place_search_widget.dart';

class HotelSearchWidget extends StatelessWidget {
  final Function(HotelSearch) onSearchClick;
  final HotelSearch? initialData;
  const HotelSearchWidget(
      {super.key, required this.onSearchClick, this.initialData});

  Future<void> onDatePicked(BuildContext context) async {
    var datesSelected = (await WidgetUtil.showBottomSheet(
        context,
        DatePicker(
          isRangePicker: true,
          requireBothStartAndEndDates: true,
          startDate: context.read<HotelSearchCubit>().state.checkInDate,
          endDate: context.read<HotelSearchCubit>().state.checkOutDate,
        ))) as List?;
    if (datesSelected != null && datesSelected.isNotEmpty) {
      if (datesSelected.length > 1) {
        context.read<HotelSearchCubit>().onCheckInDateChange(datesSelected[0]);
        context.read<HotelSearchCubit>().onCheckOutDateChange(datesSelected[1]);
      } else {
        WidgetUtil.showSnackBar(
          "Please select both check-in and check-out dates",
          context,
        );
      }
    }
  }

  String getTravellerDetails(HotelSearchState state) {
    String base = "${state.roomCount} Rooom";
    base += ", ${state.adultCount} Adults";

    if (state.childAges.isNotEmpty) {
      base += ", ${state.childAges.length} Children";
    }

    return base;
  }

  void onPlaceSearchClick(BuildContext context) async {
    await WidgetUtil.showBottomSheet(
      context,
      radius: 24,
      BlocProvider.value(
        value: context.read<HotelSearchCubit>(),
        child: PlaceSearchBottomSheet(
          onClick: (place) {
            context.read<HotelSearchCubit>().onPlaceChange(place);
            Navigator.pop(context);
          },
          onError: (error) {
            WidgetUtil.showSnackBar("Error occured, try again!", context);
          },
        ),
      ),
    );
  }

  void onTravelerClassChange(BuildContext context) async {
    var state = context.read<HotelSearchCubit>().state;
    var response = await WidgetUtil.showWrapContentBottomSheet(
        context: context,
        maxHeightFraction: 0.9,
        child: BlocProvider.value(
          value: context.read<HotelSearchCubit>(),
          child: HotelTravellerCountSelectionWidget(
            adultCount: state.adultCount,
            childCount: state.childAges.length,
            childAges: state.childAges,
            roomCount: state.roomCount,
          ),
        ));
    if (response == null) {
      return;
    }
    var (adultCount, childCount, roomCount, childAges) = response;
    context.read<HotelSearchCubit>().onAdultCountChange(adultCount);
    context.read<HotelSearchCubit>().onUpdateChildAge(childAges);
    context.read<HotelSearchCubit>().onRoomCountChange(roomCount);
  }

  List<String> validateSegments(HotelSearchState searchState) {
    List<String> errors = [];

    if (searchState.checkInDate == null) {
      errors.add("Please select check-in date");
    }
    if (searchState.checkOutDate == null) {
      errors.add("Please select check-out date");
    }
    if (searchState.checkInDate != null && searchState.checkOutDate != null) {
      if (searchState.checkInDate!.isAfter(searchState.checkOutDate!)) {
        errors.add("Check-in date cannot be after check-out date");
      }
    }
    if (searchState.roomCount <= 0) {
      errors.add("Please select at least one room");
    }
    if (searchState.adultCount <= 0) {
      errors.add("Please select at least one adult");
    }
    if (searchState.childAges.isNotEmpty &&
        searchState.childAges.length > searchState.roomCount) {
      errors.add("Number of children cannot be more than number of rooms");
    }
    if (searchState.place == null) {
      errors.add("Please select a place");
    }

    return errors;
  }

  @override
  Widget build(BuildContext context) {
    final selectedTrip = context.read<TripCubit>().selectedTrip;

    return BlocProvider(
      create: (context) => HotelSearchCubit(selectedTrip: selectedTrip)
        ..loadInitial(hotelSearch: initialData),
      child: BlocListener<HotelSearchCubit, HotelSearchState>(
        listener: (context, state) {},
        child: BlocBuilder<HotelSearchCubit, HotelSearchState>(
          builder: (context, state) {
            if (state.error != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                WidgetUtil.showSnackBar(
                    "Error fetching airports, try again", context);
                Navigator.of(context).pop();
              });
            }
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: AppColors.primaryTextSwatch[200]!)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    child: Column(
                      children: [
                        LabeledInfoWidget(
                          title: "City, Area or Property Name",
                          content: state.place?.address ?? "",
                          onCLick: () => onPlaceSearchClick(context),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: LabeledInfoWidget(
                                  title: "Check-in",
                                  content: state.checkInDate != null
                                      ? CustomDateUtils.dayMonthYearFormat(
                                          state.checkInDate!)
                                      : "Select Date",
                                  onCLick: () async {
                                    onDatePicked(context);
                                  }),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              child: LabeledInfoWidget(
                                  title: "Check-out",
                                  content: state.checkOutDate != null
                                      ? CustomDateUtils.dayMonthYearFormat(
                                          state.checkOutDate!)
                                      : "Select Date",
                                  onCLick: () async {
                                    onDatePicked(context);
                                  }),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        LabeledInfoWidget(
                          title: "Rooms & Guests",
                          content: getTravellerDetails(state),
                          onCLick: () => onTravelerClassChange(context),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        CustomButton(
                          text: "Search",
                          onPressed: () {
                            var erroees = validateSegments(state);
                            if (erroees.isNotEmpty) {
                              WidgetUtil.showSnackBar(
                                  erroees.firstOrNull!, context);
                              return;
                            }

                            var airSearch = context
                                .read<HotelSearchCubit>()
                                .getHotelSearch();
                            context
                                .read<HomeScreenCubit>()
                                .saveHotelRecentSearches(airSearch);

                            onSearchClick(airSearch);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black26,
                      width: double.infinity,
                      child: const CupertinoActivityIndicator(
                        color: Colors.black87,
                        radius: 35,
                      ),
                    ),
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
