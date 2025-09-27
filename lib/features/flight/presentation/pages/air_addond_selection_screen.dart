import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/cubit/flight_booking/flight_booking_cubit.dart';
import 'package:yellow_rose/features/flight/presentation/pages/booking_detailed_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/meal/traveller_meal_selection_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/seatMap/seat_map_selection_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/traveller_addons_selection_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';

class AirAddonSelectionScreen extends StatefulWidget {
  final AirSearch airSearch;
  static const routeName = "/flightAddonScreen";

  const AirAddonSelectionScreen({super.key, required this.airSearch});

  @override
  State<AirAddonSelectionScreen> createState() =>
      _AirAddonSelectionScreenState();
}

class _AirAddonSelectionScreenState extends State<AirAddonSelectionScreen>
    with TickerProviderStateMixin {
  TabController? seatmapController;
  TabController? mealController;
  TabController? addOnsController;

  TabController? controller;

  int seatMapIndex = 0;
  int mealIndex = 0;
  int addOnIndex = 0;

  bool showBook() {
    if (controller != null) {
      if (controller!.length - 1 == controller!.index) {
        return addOnsController!.length - 1 == addOnsController!.index;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: getFlightDetailTitle(widget.airSearch),
        subTitle: getFLightDetailSubtitle(widget.airSearch),
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: BlocBuilder<FlightBookingCubit, FlightBookingState>(
        builder: (context, state) {
          if (state is FlightBookingLoaded) {
            return SizedBox(
              height: 95.h,
              width: double.infinity,
              child: BottomButton(
                buttonText: showBook() ? "Book" : "Continue",
                title:
                    "₹ ${context.read<FlightBookingCubit>().getTotalPrice().toStringAsFixed(1)}",
                subtitle: "Total Cost",
                onClick: () async {
                  if (controller!.index == 0) {
                    // Seats tab
                    if (seatmapController!.index !=
                        seatmapController!.length - 1) {
                      seatmapController!
                          .animateTo(seatmapController!.index + 1);
                    } else {
                      seatmapController!.animateTo(0);
                      controller!.animateTo(controller!.index + 1);
                    }
                  } else if (controller!.index == 1) {
                    // Meals tab
                    if (mealController!.index != mealController!.length - 1) {
                      mealController!.animateTo(mealController!.index + 1);
                    } else {
                      mealController!.animateTo(0);
                      controller!.animateTo(controller!.index + 1);
                    }
                  } else {
                    // Add-ons tab (index == 2)
                    if (addOnsController!.index !=
                        addOnsController!.length - 1) {
                      addOnsController!.animateTo(addOnsController!.index + 1);
                    } else {
                      try {
                        var response = await context
                            .read<FlightBookingCubit>()
                            .updatePassengerDetailsAndSssr();
                        var state = (context.read<FlightBookingCubit>().state)
                            as FlightBookingLoaded;
                        if (response.priceData == null) {
                          WidgetUtil.showSnackBar(
                              "Fail To Update Booking, Try Again", context);
                          return;
                        }
                        Navigator.of(context).pushNamed(
                          BookingDetailedScreen.routeName,
                          arguments: {
                            "bookingData": state,
                            "orderUpdateResponse": response
                          },
                        );
                      } catch (e, s) {
                        log("$e $s");
                        WidgetUtil.showSnackBar(
                            "Fail To Update Booking, Try Again", context);
                        return;
                      }
                    }
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
              if (seatmapController == null) {
                seatmapController ??=
                    TabController(length: state.seatMaps.length, vsync: this);
                seatmapController!.addListener(() {
                  setState(() {
                    seatMapIndex = seatmapController!.index;
                  });
                });
              }
              if (mealController == null) {
                mealController ??=
                    TabController(length: state.seatMaps.length, vsync: this);
                mealController!.addListener(() {
                  setState(() {
                    mealIndex = mealController!.index;
                  });
                });
              }
              if (addOnsController == null) {
                addOnsController ??=
                    TabController(length: state.seatMaps.length, vsync: this);
                addOnsController!.addListener(() {
                  setState(() {
                    addOnIndex = addOnsController!.index;
                  });
                });
              }

              return DefaultTabController(
                length: 3,
                child: Builder(builder: (context) {
                  if (controller == null) {
                    controller = DefaultTabController.of(context);
                    controller!.addListener(() {
                      addOnIndex = controller!.index;
                    });
                  }
                  return Column(
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
                          child: RoundedTabBars(
                            onTap: (idx) {},
                            children: const [
                              Tab(text: "Seats"),
                              Tab(text: "Meals"),
                              Tab(text: "Add Ons"),
                            ],
                          )),
                      Expanded(
                        child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              SeatMapSelectionWidget(
                                controller: seatmapController!,
                                selectedSeats: state.selectedSeats,
                                seatMaps: state.seatMaps,
                                maxSeatToBeSelected:
                                    widget.airSearch.adultCount +
                                        widget.airSearch.childCount,
                                onSeatSelect: (flightDetailsKey, selectedSeat) {
                                  context
                                      .read<FlightBookingCubit>()
                                      .onSeatSelect(widget.airSearch,
                                          flightDetailsKey, selectedSeat);
                                },
                              ),
                              TravelerMealSelectionWidget(
                                  passengerDetails: state.passengerDetails,
                                  selectedSsr: state.selectedSsr,
                                  ssrs: state.ssrOptions,
                                  controller: mealController!,
                                  onMealSelect: (flightDetailsKey, passengerId,
                                      ssrOption) {
                                    context
                                        .read<FlightBookingCubit>()
                                        .onMealSelect(flightDetailsKey,
                                            passengerId, ssrOption);
                                  }),
                              TravelerAddOnsSelectionWidget(
                                  passengerDetails: state.passengerDetails,
                                  selectedBaggage: state.selectedBaggage,
                                  selectedSpecialRequests:
                                      state.selectedSpecialRequests,
                                  ssrs: state.ssrOptions,
                                  controller: addOnsController!,
                                  onBaggageSelect: (flightDetailsKey,
                                      passengerId, ssrOption) {
                                    context
                                        .read<FlightBookingCubit>()
                                        .onBaggageSelect(flightDetailsKey,
                                            passengerId, ssrOption);
                                  },
                                  onSpecialRequestSelect: (flightDetailsKey,
                                      passengerId, ssrOption) {
                                    context
                                        .read<FlightBookingCubit>()
                                        .onSpecialRequestSelect(
                                            flightDetailsKey,
                                            passengerId,
                                            ssrOption);
                                  })
                            ]),
                      )
                    ],
                  );
                }),
              );
            }
            return const Loader();
          },
        ),
      ),
    );
  }
}
