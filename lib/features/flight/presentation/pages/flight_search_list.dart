import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/default_tab_controller_listner.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/constants/airline_code.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_filter/flight_search_filter_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_listing_cubit/flight_search_listing_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_result_filter_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/selected_itinaries_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/selected_itinery_detail.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_search_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/itineray_detail_card.dart';

String getFlightDetailTitle(AirSearch airSearch) {
  if (airSearch.sources.length < 3) {
    return "${airSearch.sources[0].source!.city} -> ${airSearch.sources[0].destination!.city}";
  } else {
    return airSearch.sources.map((d) => d.source!.city).join(" > ");
  }
}

String getTravellerDetails(AirSearch airSearch) {
  String base =
      " | ${airSearch.adultCount} Adult${airSearch.adultCount > 1 ? 's' : ''}";
  if (airSearch.childCount > 0 || airSearch.infantCount > 0) {
    base =
        " | ${airSearch.adultCount + airSearch.childCount + airSearch.infantCount} Travelers";
  }

  return base;
}

String getFLightDetailSubtitle(AirSearch airSearch) {
  if (airSearch.sources.length == 1) {
    var baseString = CustomDateUtils.dayMonthFormat(
            airSearch.sources[0].sourceDate!) +
        (airSearch.sources[0].returnDate != null
            ? " - ${CustomDateUtils.dayMonthFormat(airSearch.sources[0].returnDate!)}"
            : '');
    baseString += getTravellerDetails(airSearch);
    return baseString;
  } else {
    return "";
  }
}

class FlightSearchListScreen extends StatelessWidget {
  static const String routeName = "/flightSearchListScreen";

  const FlightSearchListScreen({super.key});

  void onAppBarClick(BuildContext context) {
    WidgetUtil.showBottomSheet(
        context,
        FlightSearchWidget(
          initialData: context.read<FlightSearchListingCubit>().state.airSearch,
          onSearchClick: (search) {
            Navigator.of(context).pop();
            context.read<FlightSearchListingCubit>().searchFlights(search);
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    TabController? controller;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.h),
        child: BlocBuilder<FlightSearchListingCubit, FlightSearchListingState>(
          builder: (context, state) {
            return BaseAppBar(
              title: getFlightDetailTitle(state.airSearch!),
              onAppBarClick: () => onAppBarClick(context),
              subTitle: getFLightDetailSubtitle(state.airSearch!),
              shouldHaveRadius: false,
              actionsCustom: [
                Container(
                    margin: EdgeInsets.only(right: 8.w),
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onAppBarClick(context),
                    ))
              ],
            );
          },
        ),
      ),
      floatingActionButton:
          BlocBuilder<FlightSearchListingCubit, FlightSearchListingState>(
              builder: (context, state) {
        if (controller != null &&
            state is FlightSearchListingLoaded &&
            state.airSearchResponse.isNotEmpty) {
          return FloatingActionButton(
            onPressed: () async {
              final cubit = context.read<FlightSearchListingCubit>();
              var isReturn = state.airSearch!.sources.length == 1 &&
                  state.airSearch!.sources[0].returnDate != null;
              var searhcPair = isReturn
                  ? state.airSearch!.sources[0]
                  : state.airSearch!.sources[state.currentIndex];
              if (isReturn && state.currentIndex == 1) {
                searhcPair = searhcPair.copyWith(
                    source: searhcPair.destination,
                    destination: searhcPair.source);
              }

              final airLineCodes = state
                  .airSearchResponse[state.currentIndex].flights
                  .expand((flight) => flight.flightDetailsList)
                  .map((flightDetail) => flightDetail.carrierName)
                  .toSet()
                  .toList();

              var result = await WidgetUtil.showBottomSheet(
                context,
                FlightResultFilterScreen(
                  sourceDestinationDatePair: searhcPair,
                  airLineCodes: airLineCodes,
                  filterState:
                      state.flightSearchFilterState[state.currentIndex],
                ),
              );
              if (result != null && result is FlightSearchFilterState) {
                cubit.onFlightFilterChange(result);
              }
            },
            child: const Icon(Icons.filter_alt_outlined),
          );
        }
        return const SizedBox();
      }),
      bottomNavigationBar:
          BlocBuilder<FlightSearchListingCubit, FlightSearchListingState>(
        builder: (context, state) {
          if (state is FlightSearchListingLoaded) {
            if (state.airSearchResponse.isEmpty ||
                state.airSearchResponse.any((test) => test.flights.isEmpty)) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: 95.h,
              child: BottomButton(
                buttonText:
                    (state.airSearchResponse.length == state.currentIndex + 1)
                        ? "Book"
                        : "Continue",
                title:
                    "₹ ${context.read<FlightSearchListingCubit>().getTotalCost().toStringAsFixed(1)}",
                subtitle: "TOTAL COST",
                onClick: () {
                  if ((state.airSearchResponse.length ==
                      state.currentIndex + 1)) {
                    WidgetUtil.showBottomSheet(
                        context,
                        SelectedItinerariesScreen(
                          selectedItineraries:
                              state.selectedItineraries.values.toList(),
                          airSearch: state.airSearch!,
                        ));
                  } else {
                    if (controller != null) {
                      var newIndex = controller!.index + 1;
                      context
                          .read<FlightSearchListingCubit>()
                          .onIndexChange(newIndex);
                      controller!.animateTo(newIndex);
                    }
                  }
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocListener<FlightSearchListingCubit, FlightSearchListingState>(
        listener: (context, state) {
          if (state is FlightSearchListingError) {
            Navigator.of(context).pop();
            WidgetUtil.showSnackBar("Error, please try again", context);
          }
        },
        child: BlocBuilder<FlightSearchListingCubit, FlightSearchListingState>(
          builder: (context, state) {
            if (state is FlightSearchListingLoaded) {
              if (state.selectedItineraries.entries.isEmpty) {
                return Center(
                  child: Text(
                    "No Flights Found",
                    style: TextStyles.bodyLargeBoldStyle(),
                  ),
                );
              }
              return DefaultTabController(
                length: state.selectedItineraries.entries.length,
                initialIndex: state.currentIndex,
                child: DefaultTabControllerListener(
                  onTabChanged: (index) {
                    context
                        .read<FlightSearchListingCubit>()
                        .onIndexChange(index);
                  },
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: state.selectedItineraries.entries.isEmpty
                                ? 0.h
                                : 160.h,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Builder(builder: (context) {
                        controller = DefaultTabController.of(context);
                        return Column(
                          children: [
                            if (state.selectedItineraries.entries.length == 2)
                              SizedBox(
                                height: 20.h,
                              ),
                            if (state.selectedItineraries.entries.length > 1)
                              RoundedTabBars(
                                  isScrollable:
                                      state.selectedItineraries.entries.length >
                                          2,
                                  onTap: (index) {
                                    context
                                        .read<FlightSearchListingCubit>()
                                        .onIndexChange(index);
                                  },
                                  tabBarHeight: 65.h,
                                  children: (state.selectedItineraries.entries
                                      .map((entry) {
                                    var value = entry.value;
                                    var isSelcted =
                                        state.currentIndex == entry.key;
                                    return Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Center(
                                          child: Container(
                                            width: 140.w,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8.h),
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${value.flightDetailsList.first.fromAirport} - ${value.flightDetailsList.last.toAirport}",
                                                    style: TextStyles
                                                            .bodySmallSemiBoldStyle()
                                                        .copyWith(
                                                            color: !isSelcted
                                                                ? Colors.white
                                                                : AppColors
                                                                    .primary),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${CustomDateUtils.timeIn24(value.flightDetailsList.first.schDepartureTime)} - ${CustomDateUtils.timeIn24(value.flightDetailsList.last.schArrivalTime)}",
                                                    style: TextStyles
                                                            .bodySmallSemiBoldStyle()
                                                        .copyWith(
                                                            color: !isSelcted
                                                                ? Colors.white
                                                                : AppColors
                                                                    .primary),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "₹ ${value.fare.first.baseFare + value.fare.first.finalTax}",
                                                    style: TextStyles
                                                            .bodySmallStyle()
                                                        .copyWith(
                                                            color: !isSelcted
                                                                ? Colors.white
                                                                : AppColors
                                                                    .primary),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: -25.h,
                                          left: 60.h,
                                          child: Text(
                                            state.selectedItineraries.entries
                                                            .length ==
                                                        2 &&
                                                    state.airSearch?.sources
                                                            .length ==
                                                        1
                                                ? (entry.key == 0
                                                    ? "Departure"
                                                    : "Return")
                                                : "",
                                            textAlign: TextAlign.center,
                                            style: TextStyles
                                                    .bodyMediumSemiBoldStyle()
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList()) as List<Widget>),
                            Expanded(
                              child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: state.airSearchResponse
                                      .mapIndexed((index, searchResponse) {
                                    var filteredData = context
                                        .read<FlightSearchListingCubit>()
                                        .getFilteredData();
                                    if (filteredData.isEmpty) {
                                      return Center(
                                        child: Text(
                                          "No Flights Found",
                                          style:
                                              TextStyles.bodyLargeBoldStyle(),
                                        ),
                                      );
                                    }

                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      margin: state.selectedItineraries.entries
                                                  .length >
                                              1
                                          ? EdgeInsets.only(top: 10.h)
                                          : null,
                                      child: ListView.separated(
                                        itemCount: filteredData.length,
                                        itemBuilder: (ctx, idx) {
                                          var airResponseData =
                                              filteredData[idx];
                                          var isSelected = context
                                              .read<FlightSearchListingCubit>()
                                              .isSelected(airResponseData);

                                          return GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              context
                                                  .read<
                                                      FlightSearchListingCubit>()
                                                  .onSelectItinerary(
                                                      index, airResponseData);
                                            },
                                            child: ItineraryDetailCard(
                                              isSelected: isSelected,
                                              airResponseData: airResponseData,
                                              flightSearchClass:
                                                  state.airSearch!.searchClass!,
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 16.h,
                                          );
                                        },
                                      ),
                                    );
                                  }).toList()),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              );
            }
            return const Loader();
          },
        ),
      ),
    );
  }
}
