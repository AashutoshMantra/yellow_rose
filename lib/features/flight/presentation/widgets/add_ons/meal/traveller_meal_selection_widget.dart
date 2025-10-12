import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssor_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/ssr_response.dart';
import 'package:yellow_rose/features/flight/domain/entities/passenger_details_entity.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/addon_price_details.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/meal/meal_selection_widget.dart';

class TravelerMealSelectionWidget extends StatefulWidget {
  final List<PassengerDetailsEntity> passengerDetails;
  final Map<String, Map<String, SsrOption>> selectedSsr;
  final Map<String, SsrResponse?> ssrs;
  final TabController controller;
  final Function(String, String, SsrOption?) onMealSelect;
  const TravelerMealSelectionWidget(
      {super.key,
      required this.passengerDetails,
      required this.selectedSsr,
      required this.ssrs,
      required this.controller,
      required this.onMealSelect});

  @override
  State<TravelerMealSelectionWidget> createState() =>
      _TravelerMealSelectionWidgetState();
}

class _TravelerMealSelectionWidgetState
    extends State<TravelerMealSelectionWidget>
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

  @override
  Widget build(BuildContext context) {
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
                        // return SeatMapWidget(
                        //   key: ValueKey(seatmapResponse.key),
                        //   seatRows: seatmapResponse.value!.airSeatRows,
                        //   selectedSeat:
                        //       widget.selectedSeats[seatmapResponse.key] ?? [],
                        //   onSeatSelect: (selectedSeat) {
                        //     widget.onSeatSelect(
                        //         seatmapResponse.key, selectedSeat);
                        //   },
                        // );

                        return MealSelectionWidget(
                            passengerDetails: widget.passengerDetails,
                            selectedSsr: widget.selectedSsr[ssrsResponse.key] ??
                                <String, SsrOption>{},
                            onMealSelect: (passengerid, ssrOption) {
                              widget.onMealSelect(
                                  ssrsResponse.key, passengerid, ssrOption);
                            },
                            ssrs: ssrsResponse.value);
                        return const SizedBox.shrink();
                      }).toList()),
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
            child: (currentIndex < widget.ssrs.keys.toList().length &&
                    (widget.selectedSsr[
                                widget.ssrs.keys.toList()[currentIndex]] ??
                            {})
                        .isEmpty)
                ? const Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox.shrink(),
                  )
                : Builder(builder: (context) {
                    if (currentIndex < widget.ssrs.keys.toList().length) {
                      var meals = widget
                          .selectedSsr[widget.ssrs.keys.toList()[currentIndex]]!
                          .values;
                      var seatCosts =
                          meals.map((s) => s.totalCost).reduce((a, b) => a + b);
                      var mealString = meals.map((s) => s.code).join(", ");
                      return Align(
                        alignment: Alignment.bottomCenter,
                        child: AddonPriceDetails(
                          title: "Meals - $mealString",
                          subtitle:
                              "${meals.length} of ${widget.passengerDetails.where((d) => !d.passengerType.isInfant()).length} Meals Selected",
                          rightTitle: "₹ $seatCosts",
                          rightSubtitle: "Added to fare",
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  })),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
