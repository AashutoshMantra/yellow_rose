import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/common_widgets/pill_button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/domain/entities/search_filter.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_filter/flight_search_filter_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';

class FlightResultFilterScreen extends StatelessWidget {
  final FlightSearchFilterState? filterState;
  final SourceDestinationDatePair sourceDestinationDatePair;
  final List<String> airLineCodes;
  final Function? onClick;
  const FlightResultFilterScreen(
      {super.key,
      this.filterState,
      required this.sourceDestinationDatePair,
      required this.airLineCodes,
      this.onClick});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FlightSearchFilterCubit(flightSearchState: filterState),
      child: BlocBuilder<FlightSearchFilterCubit, FlightSearchFilterState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * .85,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BottomSheetTitleWidget(title: "Filter"),
                      SizedBox(
                        height: 12.h,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Sort",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                children: [
                                  ...AirSortBy.values.map((airSortby) {
                                    return PillButton(
                                      text: airSortby.text,
                                      onClick: () {
                                        context
                                            .read<FlightSearchFilterCubit>()
                                            .onChangeSortBy(airSortby);
                                      },
                                      pillType: state.sortBy == airSortby
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                  "Departure From ${sourceDestinationDatePair.source?.city ?? ''}",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...FlightTiming.values.map((departureTiming) {
                                    return PillButton(
                                      text:
                                          "${departureTiming.text} \n (${departureTiming.timing})",
                                      onClick: () {
                                        context
                                            .read<FlightSearchFilterCubit>()
                                            .onClickDepartureTimingFilter(
                                                departureTiming);
                                      },
                                      pillType: state.departure
                                              .contains(departureTiming)
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text(
                                  "Arrival at ${sourceDestinationDatePair.destination?.city ?? ''}",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...FlightTiming.values.map((departureTiming) {
                                    return PillButton(
                                      text:
                                          "${departureTiming.text} \n (${departureTiming.timing})",
                                      onClick: () {
                                        context
                                            .read<FlightSearchFilterCubit>()
                                            .onClickArrivalTimingFilter(
                                                departureTiming);
                                      },
                                      pillType: state.arrival
                                              .contains(departureTiming)
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Text("Airlines",
                                  style:
                                      TextStyles.bodyLargeBoldStyle().copyWith(
                                    color: AppColors.primaryTextSwatch[500],
                                  )),
                              SizedBox(
                                height: 20.h,
                              ),
                              Wrap(
                                spacing: 10.h,
                                runSpacing: 16.h,
                                alignment: WrapAlignment.start,
                                children: [
                                  ...airLineCodes.map((airline) {
                                    return PillButton(
                                      text: airline,
                                      onClick: () {
                                        context
                                            .read<FlightSearchFilterCubit>()
                                            .onClickAirlineFilter(airline);
                                      },
                                      pillType: state.airlines.contains(airline)
                                          ? PillType.primary
                                          : PillType.secondary,
                                    );
                                  })
                                ],
                              ),
                              SizedBox(
                                height: 120.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.infinity,
                    height: 95.h,
                    child: BottomButton(
                        title: "",
                        onClick: () {
                          Navigator.of(context).pop(state);
                        },
                        buttonText: "Apply"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
