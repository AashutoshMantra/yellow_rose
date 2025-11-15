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
import 'package:yellow_rose/features/bus/domain/entities/bus_search.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/search/bus_search_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_city_search_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';

class BusSearchWidget extends StatelessWidget {
  final Function(BusSearch) onSearchClick;
  final BusSearch? initialData;
  const BusSearchWidget({
    super.key,
    required this.onSearchClick,
    this.initialData,
  });

  Future<void> onDatePicked(BuildContext context) async {
    var datesSelected = (await WidgetUtil.showBottomSheet(
      context,
      DatePicker(
        isRangePicker: false,
        startDate: context.read<BusSearchCubit>().state.dateOfJourney,
      ),
    )) as List?;
    if (datesSelected != null && datesSelected.isNotEmpty) {
      context.read<BusSearchCubit>().onDateChange(datesSelected[0]);
    }
  }

  void onCitySearchClick(BuildContext context, bool isSource) async {
    await WidgetUtil.showBottomSheet(
      context,
      BusCitySearchScreen(
        onClick: (city) {
          if (isSource) {
            context.read<BusSearchCubit>().onSourceChange(city);
          } else {
            context.read<BusSearchCubit>().onDestinationChange(city);
          }
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          BusSearchCubit()..loadInitial(busSearch: initialData),
      child: BlocBuilder<BusSearchCubit, BusSearchState>(
        builder: (context, state) {
          if (state.isLoading) {
            Positioned.fill(
              child: Container(
                color: Colors.black26,
                width: double.infinity,
                child: const CupertinoActivityIndicator(
                  color: Colors.black87,
                  radius: 35,
                ),
              ),
            );
          }
          return Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // From
                InkWell(
                  onTap: () => onCitySearchClick(context, true),
                  child: LabeledInfoWidget(
                    title: "From",
                    content: state.source?.cityName ?? "Select Source",
                  ),
                ),
                // Swap button

                SizedBox(height: 8.h),
                // To
                InkWell(
                  onTap: () => onCitySearchClick(context, false),
                  child: LabeledInfoWidget(
                    title: "To",
                    content:
                        state.destination?.cityName ?? "Select Destination",
                  ),
                ),
                SizedBox(height: 8.h),
                // Date
                InkWell(
                  onTap: () => onDatePicked(context),
                  child: LabeledInfoWidget(
                    title: "Date of Journey",
                    content: state.dateOfJourney != null
                        ? CustomDateUtils.givenFormat(
                            state.dateOfJourney!, "dd MMM yyyy")
                        : "Select Date",
                  ),
                ),
                SizedBox(height: 24.h),
                // Search Button
                CustomButton(
                  text: "Search Bus",
                  onPressed: () {
                    if (state.source != null &&
                        state.destination != null &&
                        state.dateOfJourney != null) {
                      final busSearch =
                          context.read<BusSearchCubit>().getBusSearch();
                      context
                          .read<HomeScreenCubit>()
                          .saveBusRecentSearches(busSearch);
                      onSearchClick(busSearch);
                    } else {
                      WidgetUtil.showSnackBar(
                          "Please fill all fields", context);
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
