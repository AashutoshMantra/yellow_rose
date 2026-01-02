import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/ImageIcon.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/common_widgets/date_picker.dart';
import 'package:yellow_rose/core/common_widgets/flex_switch.dart';
import 'package:yellow_rose/core/common_widgets/labeled_info_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/domain/entities/source_date_pair.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_search_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/airport_search_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/traveller_class_selection_screen.dart';
import 'package:yellow_rose/features/home_screen/presentation/cubit/home_screen_cubit.dart';
import 'package:yellow_rose/core/constants/airline_code.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/airline_selection_sheet.dart';
import 'package:yellow_rose/features/flight/domain/entities/name_code.dart';

class FlightSearchWidget extends StatelessWidget {
  final Function(AirSearch) onSearchClick;
  final AirSearch? initialData;
  const FlightSearchWidget(
      {super.key, required this.onSearchClick, this.initialData});

  Future<void> onDatePicked(BuildContext context, bool isMulti) async {
    var datesSelected = (await WidgetUtil.showBottomSheet(
        context,
        DatePicker(
          isRangePicker: isMulti,
          startDate:
              context.read<FlightSearchCubit>().state.sources[0].sourceDate,
          endDate:
              context.read<FlightSearchCubit>().state.sources[0].returnDate,
        ))) as List?;
    if (datesSelected != null && datesSelected.isNotEmpty) {
      context.read<FlightSearchCubit>().onSourceDateChange(datesSelected[0]);
      if (datesSelected.length > 1) {
        context.read<FlightSearchCubit>().onReturnDateChange(datesSelected[1]);
      } else {
        context.read<FlightSearchCubit>().onReturnDateChange(null);
      }
    }
  }

  String getTravellerDetails(FlightSearchState state) {
    String base = "${state.adultCount} Adults";
    if (state.childCount > 0) {
      base += ", ${state.childCount} Children";
    }
    if (state.infantCount > 0) {
      base += ", ${state.infantCount} Infant";
    }
    return base;
  }

  void onTravelerClassChange(BuildContext context) async {
    var state = context.read<FlightSearchCubit>().state;
    var response = await WidgetUtil.showBottomSheet(
        context,
        radius: 24,
        BlocProvider.value(
          value: context.read<FlightSearchCubit>(),
          child: TravelerClassSelectionScreen(
            adultCount: state.adultCount,
            childCount: state.childCount,
            infantCount: state.infantCount,
            searchClass: state.searchClass,
          ),
        ));
    if (response == null) {
      return;
    }
    var (adultCount, childCount, infantCount, searchClass) = response;
    context.read<FlightSearchCubit>().onAdultChange(adultCount);
    context.read<FlightSearchCubit>().onChildChange(childCount);
    context.read<FlightSearchCubit>().onInfantChange(infantCount);
    context.read<FlightSearchCubit>().onClassChange(searchClass);
  }

  Widget getFromToWidget(BuildContext context, FlightSearchState state,
      String title, String? content,
      {required VoidCallback onClick}) {
    return LabeledInfoWidget(
      leading: const CustomImageIcon(
        image: AssetImage("assets/images/icons/takeoff.png"),
        backgroundColor: Colors.white,
      ),
      title: title,
      content: content ?? "",
      onCLick: onClick,
    );
  }

  Widget getAirlineWidget(BuildContext context, FlightSearchState state) {
    // build carriers list from map
    final carriers = carrierCodeNameMap.entries
        .map((e) => NameCode(name: e.value, code: e.key))
        .toList();

    return LabeledInfoWidget(
      leading: const CustomImageIcon(
        image: AssetImage("assets/images/icons/air.png"),
        backgroundColor: Colors.white,
      ),
      title: "Airline",
      content: state.preferredCarrier?.name ?? 'Any Airline',
      onCLick: () async {
        var result = await WidgetUtil.showBottomSheet(
            context,
            AirlineSelectionSheet(
              initial: state.preferredCarrier,
              carriers: carriers,
            ));
        if (result != null && result is NameCode) {
          context.read<FlightSearchCubit>().onPreferredCarrierChange(result);
        } else if (result == null) {
          context.read<FlightSearchCubit>().onPreferredCarrierChange(null);
        }
      },
    );
  }

  List<String> validateSegments(List<SourceDestinationDatePair> segments) {
    List<String> errors = [];

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];
      final isMultiSegment = segments.length > 1;
      final prefix = isMultiSegment ? 'Segment ${i + 1}: ' : '';

      if (segment.source?.iataCode == null ||
          segment.source!.iataCode!.isEmpty) {
        errors.add('${prefix}Missing source airport.');
      }

      if (segment.destination?.iataCode == null ||
          segment.destination!.iataCode!.isEmpty) {
        errors.add('${prefix}Missing destination airport.');
      }

      if (segment.sourceDate == null) {
        errors.add('${prefix}Missing departure date.');
      }
    }

    return errors;
  }

  int getInitialIndex() {
    if (initialData == null) {
      return 0;
    }
    if (initialData!.sources.length == 1) {
      if (initialData!.sources[0].returnDate != null) {
        return 1;
      }
      return 0;
    }
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FlightSearchCubit()..loadInitial(airSearch: initialData),
      child: DefaultTabController(
        length: 3,
        initialIndex: getInitialIndex(),
        child: BlocListener<FlightSearchCubit, FlightSearchState>(
          listener: (context, state) {
            if (state.sources.isNotEmpty &&
                state.sources[0].returnDate != null) {
              DefaultTabController.of(context).animateTo(1);
            } else if (DefaultTabController.of(context).index == 1) {
              DefaultTabController.of(context).animateTo(0);
            }
          },
          child: BlocBuilder<FlightSearchCubit, FlightSearchState>(
            builder: (context, state) {
              if (state.error != null) {
                WidgetUtil.showSnackBar(
                    "Error fetching airports, try again", context);
                Navigator.of(context).pop();
              }
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: AppColors.primaryTextSwatch[200]!)),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      child: Column(
                        children: [
                          TabBar(
                              dividerColor: Colors.transparent,
                              onTap: (idx) {
                                if (idx == 1) {
                                  if (state.sources[0].returnDate == null) {
                                    context
                                        .read<FlightSearchCubit>()
                                        .onReturnDateChange(DateTime.now()
                                            .add(const Duration(days: 3)));
                                  }
                                } else if (idx == 0) {
                                  context
                                      .read<FlightSearchCubit>()
                                      .onReturnDateChange(null);
                                } else {
                                  context
                                      .read<FlightSearchCubit>()
                                      .onMultiCityChange();
                                }
                              },
                              tabs: const [
                                Tab(
                                  text: "One Way",
                                ),
                                Tab(
                                  text: "Round Trip",
                                ),
                                Tab(
                                  text: "Multi City",
                                ),
                              ]),
                          SizedBox(
                            height: 16.h,
                          ),
                          if (DefaultTabController.of(context).index < 2)
                            getFromToOneWay(context, state, 0),
                          if (DefaultTabController.of(context).index == 2)
                            getFromToMultiCity(context, state),
                          SizedBox(
                            height: 20.h,
                          ),
                          LabeledInfoWidget(
                            title: "Traveler",
                            content: getTravellerDetails(state),
                            onCLick: () => onTravelerClassChange(context),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: LabeledInfoWidget(
                                    title: "Class",
                                    content: state.searchClass.text,
                                    onCLick: () =>
                                        onTravelerClassChange(context),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: getAirlineWidget(context, state),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          // Filters wrap (Direct Flight and future chips)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Wrap(
                              spacing: 8.w,
                              runSpacing: 8.h,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Checkbox(
                                      value: state.directFlight,
                                      onChanged: (v) {
                                        context
                                            .read<FlightSearchCubit>()
                                            .onDirectFlightChange(v ?? false);
                                      },
                                    ),
                                    SizedBox(width: 4.w),
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<FlightSearchCubit>()
                                            .onDirectFlightChange(
                                                !state.directFlight);
                                      },
                                      child: Text(
                                        'Direct Flight',
                                        style: TextStyles.bodyMediumStyle(),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomButton(
                            text: "Search ticket",
                            onPressed: () {
                              var erroees = validateSegments(state.sources);
                              if (erroees.isNotEmpty) {
                                WidgetUtil.showSnackBar(
                                    erroees.firstOrNull!, context);
                                return;
                              }

                              var airSearch = context
                                  .read<FlightSearchCubit>()
                                  .getAirSearch();
                              context
                                  .read<HomeScreenCubit>()
                                  .saveAirRecentSearches(airSearch);

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
      ),
    );
  }

  Widget getFromToMultiCity(
    BuildContext context,
    FlightSearchState state,
  ) {
    return Column(
      children: [
        ...state.sources.mapIndexed((idx, sourceDestinations) {
          return Column(
            children: [
              getFromToOneWay(
                context,
                state,
                idx,
                isMulti: true,
              ),
              if (idx != state.sources.length - 1)
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        height: 16.h,
                        color: AppColors.primaryTextSwatch[300],
                        thickness: 0.8,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<FlightSearchCubit>()
                              .removeMultiCity(idx);
                        },
                        icon: Icon(
                          Icons.remove_circle_outline,
                          size: 24.h,
                        )),
                    Expanded(
                      child: Divider(
                        height: 16.h,
                        color: AppColors.primaryTextSwatch[300],
                        thickness: 0.8,
                      ),
                    ),
                  ],
                )
            ],
          );
        }),
        SizedBox(
          height: 12.h,
        ),
        IconButton(
            onPressed: () {
              try {
                context.read<FlightSearchCubit>().onMultiCityChange();
              } catch (e) {
                WidgetUtil.showSnackBar(e.toString(), context,
                    milliseconds: 1000);
              }
            },
            icon: Icon(
              Icons.add_circle_outline,
              size: 32.h,
            )),
      ],
    );
  }

  Column getFromToOneWay(BuildContext context, FlightSearchState state, int idx,
      {bool isMulti = false, bool showRemove = false}) {
    final fromWidget = LabeledInfoWidget(
      leading: const CustomImageIcon(
        image: AssetImage("assets/images/icons/takeoff.png"),
        backgroundColor: Colors.white,
      ),
      title: "From",
      onCLick: () async {
        await WidgetUtil.showBottomSheet(context, AirportSearchScreen(
          onClick: (airport) {
            context.read<FlightSearchCubit>().onSourceChange(airport, idx);
            Navigator.of(context).pop();
          },
        ));
      },
      content: (state.sources.isNotEmpty && state.sources[idx].source != null)
          ? !isMulti
              ? "${state.sources[idx].source!.name} (${state.sources[idx].source!.iataCode})"
              : state.sources[idx].source!.iataCode ?? ''
          : "",
    );
    final toWidget = LabeledInfoWidget(
      leading: const CustomImageIcon(
          image: AssetImage("assets/images/icons/landing.png"),
          backgroundColor: Colors.white),
      title: "To",
      content: (state.sources.isNotEmpty &&
              state.sources[idx].destination != null)
          ? !isMulti
              ? "${state.sources[idx].destination!.name} (${state.sources[idx].destination!.iataCode})"
              : state.sources[idx].destination!.iataCode ?? ''
          : "",
      onCLick: () async {
        await WidgetUtil.showBottomSheet(context, AirportSearchScreen(
          onClick: (airport) {
            context.read<FlightSearchCubit>().onDestinationChange(airport, idx);
            Navigator.of(context).pop();
          },
        ));
      },
    );

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            FlexSwitch(isRow: isMulti, children: [
              isMulti ? Expanded(child: fromWidget) : fromWidget,
              SizedBox(
                height: isMulti ? 0 : 12.h,
                width: !isMulti ? 0 : 12.w,
              ),
              isMulti ? Expanded(child: toWidget) : toWidget,
            ]),
            if (!isMulti &&
                state.sources.isNotEmpty &&
                state.sources[idx].source != null &&
                state.sources[idx].destination != null)
              Positioned(
                left: 0,
                right: 0,
                top: 7.h,
                bottom: 0,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      context
                          .read<FlightSearchCubit>()
                          .swapSourceDestination(idx);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.primary.withOpacity(0.5),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.swap_vert,
                        color: AppColors.primary,
                        size: 20.h,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: LabeledInfoWidget(
                title: "Depart",
                onCLick: () async {
                  bool isMulti = state.sources.isNotEmpty &&
                      state.sources[idx].returnDate != null;
                  await onDatePicked(context, isMulti);
                },
                content: (state.sources.isNotEmpty &&
                        state.sources[idx].sourceDate != null)
                    ? CustomDateUtils.dayMonthYearFormat(
                        state.sources[idx].sourceDate!)
                    : "N/A",
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            if (!isMulti)
              Expanded(
                child: LabeledInfoWidget(
                  title: "Return",
                  onCLick: () async {
                    await onDatePicked(context, true);
                  },
                  content: (state.sources.isNotEmpty &&
                          state.sources[idx].returnDate != null)
                      ? CustomDateUtils.dayMonthYearFormat(
                          state.sources[idx].returnDate!)
                      : "N/A",
                ),
              ),
          ],
        ),
      ],
    );
  }
}
