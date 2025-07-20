import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/default_tab_controller_listner.dart';
import 'package:yellow_rose/core/common_widgets/rounded_tab_bar.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_map_response.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_occupancy.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_row.dart';
import 'package:yellow_rose/features/flight/domain/entities/seat_map/selected_seat.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/addon_price_details.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/seatMap/seat_map_legend.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/add_ons/seatMap/seat_map_widget.dart';

class SeatMapSelectionWidget extends StatefulWidget {
  final Map<String, List<SelectedSeat>> selectedSeats;
  final Map<String, AirSeatMapResponse?> seatMaps;
  final TabController controller;
  final int maxSeatToBeSelected;
  final Function(String, SelectedSeat) onSeatSelect;

  const SeatMapSelectionWidget(
      {super.key,
      required this.selectedSeats,
      required this.seatMaps,
      required this.onSeatSelect,
      required this.maxSeatToBeSelected,
      required this.controller});

  @override
  State<SeatMapSelectionWidget> createState() => _SeatMapSelectionWidgetState();
}

class _SeatMapSelectionWidgetState extends State<SeatMapSelectionWidget>
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
                children: widget.seatMaps.keys.map((keys) {
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
              Center(
                child: Text(
                  "Tap and select seats of your choice",
                  textAlign: TextAlign.center,
                  style: TextStyles.bodyMediumMediumStyle(),
                ),
              ),
              Expanded(
                child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: widget.controller,
                    children: widget.seatMaps.entries.map((seatmapResponse) {
                      if (seatmapResponse.value == null ||
                          seatmapResponse.value!.airSeatRows.isEmpty) {
                        return Center(
                          child: Text(
                            "Seat map not available for this flight",
                            style: TextStyles.bodyMediumMediumStyle(),
                          ),
                        );
                      }
                      return SeatMapWidget(
                        key: ValueKey(seatmapResponse.key),
                        seatRows: seatmapResponse.value!.airSeatRows,
                        selectedSeat:
                            widget.selectedSeats[seatmapResponse.key] ?? [],
                        onSeatSelect: (selectedSeat) {
                          widget.onSeatSelect(
                              seatmapResponse.key, selectedSeat);
                        },
                      );
                    }).toList()),
              ),
              SizedBox(
                height: 58.h,
              )
            ],
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
          child: (currentIndex < widget.seatMaps.keys.toList().length &&
                  (widget.selectedSeats[
                              widget.seatMaps.keys.toList()[currentIndex]] ??
                          [])
                      .isEmpty)
              ? const Align(
                  alignment: Alignment.bottomCenter,
                  child: SeatMapLegends(),
                )
              : Builder(builder: (context) {
                  if (currentIndex < widget.seatMaps.keys.toList().length) {
                    var seats = widget.selectedSeats[
                        widget.seatMaps.keys.toList()[currentIndex]]!;
                    var seatCosts = seats
                        .map((s) => s.totalCost)
                        .fold(0.0, (a, b) => a + b);
                    var seatString =
                        seats.map((s) => s.row + s.seat.column).join(", ");
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: AddonPriceDetails(
                        title: "Seats - $seatString",
                        subtitle:
                            "${seats.length} of ${widget.maxSeatToBeSelected} Seats Selected",
                        rightTitle: "₹ $seatCosts",
                        rightSubtitle: "Added to fare",
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
