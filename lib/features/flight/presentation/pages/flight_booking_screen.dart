import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/cutom_dropdown_field.dart';
import 'package:yellow_rose/core/common_widgets/labelled_drop_dowdn.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/air_addond_selection_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/dasshed_arrow_line.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/itineray_detail_card.dart';
import 'package:yellow_rose/core/common_widgets/passenger_detail/traveller_details_widget.dart';
import 'package:yellow_rose/features/trip/presentation/cubit/trip_cubit.dart';

class FlightBookingScreen extends StatelessWidget {
  final AirSearch airSearch;
  static const routeName = "/flightBookingScreen";
  const FlightBookingScreen({super.key, required this.airSearch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: getFlightDetailTitle(airSearch),
        subTitle: getFLightDetailSubtitle(airSearch),
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: BlocBuilder<FlightBookingCubit, FlightBookingState>(
        builder: (context, state) {
          if (state is FlightBookingLoaded) {
            return SizedBox(
              height: 95.h,
              width: double.infinity,
              child: BottomButton(
                buttonText: "Book",
                title:
                    "₹ ${context.read<FlightBookingCubit>().getTotalPrice().toStringAsFixed(1)}",
                subtitle: "Total Cost",
                onClick: () async {
                  var adultCount = state.passengerDetails
                      .where((p) => p.passengerType.isAdult())
                      .length;
                  var childCount = state.passengerDetails
                      .where((p) => p.passengerType.isChild())
                      .length;
                  var infantCount = state.passengerDetails
                      .where((p) => p.passengerType.isInfant())
                      .length;
                  if (state.billingEntity == null) {
                    WidgetUtil.showSnackBar(
                        "Please select billing entity", context);
                    return;
                  }
                  if (adultCount != airSearch.adultCount ||
                      childCount != airSearch.childCount ||
                      infantCount != airSearch.infantCount) {
                    WidgetUtil.showSnackBar(
                        "Please add all traveler details", context);
                  } else {
                    var gotBack = await Navigator.of(context).pushNamed(
                        AirAddonSelectionScreen.routeName,
                        arguments: {
                          "airSearch": airSearch,
                          "cubit": BlocProvider.of<FlightBookingCubit>(context)
                        });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      BlocProvider.of<FlightBookingCubit>(context)
                          .resetSsrMap();
                    });
                  }
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      body: BlocListener<FlightBookingCubit, FlightBookingState>(
        listener: (context, state) {
          if (state is FlightBookingError) {
            Navigator.of(context).pop();
            WidgetUtil.showSnackBar("Error, please try again", context);
          }
        },
        child: BlocBuilder<FlightBookingCubit, FlightBookingState>(
          builder: (context, state) {
            if (state is FlightBookingLoaded) {
              var billingEntities =
                  (context.read<AuthCubit>().state as Authenticated)
                      .billingEntities;

              final allProfiles = context.read<AuthCubit>().allProfiles;

              return SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      padding: EdgeInsets.only(
                          left: 24.w, right: 24.w, bottom: 24.h),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.selectedItineraries.length,
                        itemBuilder: (ctx, idx) {
                          return ItineraryDetail(
                            airResponseData: state.selectedItineraries[idx],
                            airSearch: airSearch,
                            fareType:
                                state.selectedFares[idx]!.fareTypeDisplay ??
                                    state.selectedFares[idx]?.fareType ??
                                    "",
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 12.h),
                            child: const DottedLine(
                              dashColor: Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          TravelerDetailsWidget(
                            maxAdult: airSearch.adultCount,
                            maxChild: airSearch.childCount,
                            maxInfant: airSearch.infantCount,
                            passengerDetails: state.passengerDetails,
                            savedProfiles: allProfiles,
                            isReadOnly:
                                context.read<TripCubit>().selectedTrip != null,
                            lockMessage: context
                                        .read<TripCubit>()
                                        .selectedTrip !=
                                    null
                                ? "Passenger details are fixed for this trip booking"
                                : null,
                            onAddUpdate: (passengerDetail) {
                              context
                                  .read<FlightBookingCubit>()
                                  .onAddUpdatePassenger(
                                      airSearch, passengerDetail);
                            },
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.primarySwatch[200]!,
                                ),
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.primaryTextSwatch[50]),
                            child: LabeledDropDownField(
                              label: "Billing Entity",
                              items: billingEntities
                                  .map((e) => e.entityName ?? "")
                                  .toList(),
                              selectedValue: state.billingEntity?.entityName,
                              onChanged: (value) {
                                var found = billingEntities.firstWhereOrNull(
                                  (e) =>
                                      e.entityName
                                          ?.equalsIgnoreCase(value ?? '') ==
                                      true,
                                );
                                context
                                    .read<FlightBookingCubit>()
                                    .onBillingEntityChange(found);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 150.h,
                          ),
                        ],
                      ),
                    ),
                  ],
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

class ItineraryDetail extends StatelessWidget {
  final AirResponseData airResponseData;
  final AirSearch airSearch;
  final String fareType;
  final String? titlePrefix;
  final bool isLight;
  final bool showIcon;
  const ItineraryDetail(
      {super.key,
      required this.airResponseData,
      required this.airSearch,
      this.isLight = false,
      required this.fareType,
      this.showIcon = true,
      this.titlePrefix});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [
        if (showIcon)
          ImageIcon(
            const AssetImage("assets/images/icons/air.png"),
            size: 17.h,
            color: !isLight ? Colors.white : AppColors.primaryText,
          ),
        if (showIcon)
          SizedBox(
            width: 26.w,
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${titlePrefix ?? ""}${airResponseData.flightDetailsList.first.fromAirport} - ${airResponseData.flightDetailsList.last.toAirport}",
              style: TextStyles.bodyMediumBoldStyle().copyWith(
                  color: !isLight ? Colors.white : AppColors.primaryText),
            ),
            SizedBox(
              height: 2.h,
            ),
            DefaultTextStyle(
              style: TextStyles.bodySmallMediumStyle().copyWith(
                  color: !isLight
                      ? Colors.white
                      : AppColors.primaryTextSwatch[600]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Text(CustomDateUtils.dayDateMonthFormat(airResponseData
                          .flightDetailsList.first.schDepartureTime)),
                      const Text(" | "),
                      Text(
                          "${CustomDateUtils.timeIn24(airResponseData.flightDetailsList.first.schDepartureTime)} - ${CustomDateUtils.timeIn24(airResponseData.flightDetailsList.last.schArrivalTime)}"),
                      const Text(" | "),
                      Text(CustomDateUtils.durationToString(
                          airResponseData.travelDuration ?? 0)),
                      const Text(" | "),
                      Text(getStopText(airResponseData)),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text("${airSearch.searchClass!.text} > $fareType")
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
