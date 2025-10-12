import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/addon_price_details.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/baggage/baggage_selection_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/special_request/special_request_selection_widget.dart';

class TravelerAddOnsSelectionWidget extends StatefulWidget {
  final List<PassengerDetailsEntity> passengerDetails;
  final Map<String, Map<String, SsrOption>> selectedBaggage;
  final Map<String, Map<String, SsrOption>> selectedSpecialRequests;
  final Map<String, SsrResponse?> ssrs;
  final TabController controller;
  final Function(String, String, SsrOption?) onBaggageSelect;
  final Function(String, String, SsrOption?) onSpecialRequestSelect;

  const TravelerAddOnsSelectionWidget({
    super.key,
    required this.passengerDetails,
    required this.selectedBaggage,
    required this.selectedSpecialRequests,
    required this.ssrs,
    required this.controller,
    required this.onBaggageSelect,
    required this.onSpecialRequestSelect,
  });

  @override
  State<TravelerAddOnsSelectionWidget> createState() =>
      _TravelerAddOnsSelectionWidgetState();
}

class _TravelerAddOnsSelectionWidgetState
    extends State<TravelerAddOnsSelectionWidget>
    with AutomaticKeepAliveClientMixin {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          currentIndex = widget.controller.index;
        });
      }
    });
  }

  double _getTotalAddOnsCost() {
    if (currentIndex < widget.ssrs.keys.toList().length) {
      var currentFlightKey = widget.ssrs.keys.toList()[currentIndex];

      var baggageCost = 0.0;
      var specialRequestCost = 0.0;

      var selectedBaggageForFlight =
          widget.selectedBaggage[currentFlightKey] ?? {};
      var selectedSpecialRequestsForFlight =
          widget.selectedSpecialRequests[currentFlightKey] ?? {};

      if (selectedBaggageForFlight.isNotEmpty) {
        baggageCost = selectedBaggageForFlight.values
            .map((s) => s.totalCost)
            .reduce((a, b) => a + b);
      }

      if (selectedSpecialRequestsForFlight.isNotEmpty) {
        specialRequestCost = selectedSpecialRequestsForFlight.values
            .map((s) => s.totalCost)
            .reduce((a, b) => a + b);
      }

      return baggageCost + specialRequestCost;
    }
    return 0.0;
  }

  String _getAddOnsDescription() {
    if (currentIndex < widget.ssrs.keys.toList().length) {
      var currentFlightKey = widget.ssrs.keys.toList()[currentIndex];

      var selectedBaggageForFlight =
          widget.selectedBaggage[currentFlightKey] ?? {};
      var selectedSpecialRequestsForFlight =
          widget.selectedSpecialRequests[currentFlightKey] ?? {};

      var totalSelections = selectedBaggageForFlight.length +
          selectedSpecialRequestsForFlight.length;
      var totalPassengers = widget.passengerDetails
          .where((d) => !d.passengerType.isInfant())
          .length;

      return "$totalSelections of $totalPassengers Add-ons Selected";
    }
    return "No add-ons selected";
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        Container(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedTabBars(
                  isScrollable: true,
                  tabController: widget.controller,
                  onTap: (idx) {},
                  borderRadius: 12.h,
                  textStyle: TextStyles.bodySmallMediumStyle(),
                  type: RoundedTabBarType.secondary,
                  children: widget.ssrs.keys.map((keys) {
                    var [flight, from, to] = keys.split("#");

                    return SizedBox(
                      height: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ImageIcon(
                              const AssetImage("assets/images/icons/air.png"),
                              size: 17.h,
                              color: AppColors.primary,
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text("$from To $to")
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Divider(
                  height: 30.h,
                  color: AppColors.primaryTextSwatch[500],
                ),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: widget.controller,
                    children: widget.ssrs.entries.map((ssrsResponse) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            // Baggage Selection Section
                            BaggageSelectionWidget(
                              passengerDetails: widget.passengerDetails,
                              selectedBaggage:
                                  widget.selectedBaggage[ssrsResponse.key] ??
                                      <String, SsrOption>{},
                              onBaggageSelect: (passengerId, ssrOption) {
                                widget.onBaggageSelect(
                                    ssrsResponse.key, passengerId, ssrOption);
                              },
                              ssrs: ssrsResponse.value,
                            ),
                            SizedBox(height: 16.h),
                            // Special Request Selection Section
                            SpecialRequestSelectionWidget(
                              passengerDetails: widget.passengerDetails,
                              selectedSpecialRequests:
                                  widget.selectedSpecialRequests[
                                          ssrsResponse.key] ??
                                      <String, SsrOption>{},
                              onSpecialRequestSelect: (passengerId, ssrOption) {
                                widget.onSpecialRequestSelect(
                                    ssrsResponse.key, passengerId, ssrOption);
                              },
                              ssrs: ssrsResponse.value,
                            ),
                            SizedBox(
                                height:
                                    100.h), // Space for bottom price details
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _getTotalAddOnsCost() <= 0
              ? const Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox.shrink(),
                )
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: AddonPriceDetails(
                    title: "Add-ons",
                    subtitle: _getAddOnsDescription(),
                    rightTitle: "₹ ${_getTotalAddOnsCost().toStringAsFixed(0)}",
                    rightSubtitle: "Added to fare",
                  ),
                ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
