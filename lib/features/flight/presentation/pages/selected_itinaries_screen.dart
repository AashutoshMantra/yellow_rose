import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/bottom_sheet_title_widget.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_booking_screen.dart';
import 'package:yellow_rose/features/flight/presentation/pages/flight_search_list.dart';
import 'package:yellow_rose/features/flight/presentation/pages/selected_itinery_detail.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/bottom_button.dart';

class SelectedItinerariesScreen extends StatefulWidget {
  final List<AirResponseData> selectedItineraries;
  final AirSearch airSearch;
  const SelectedItinerariesScreen(
      {super.key, required this.selectedItineraries, required this.airSearch});

  @override
  State<SelectedItinerariesScreen> createState() =>
      _SelectedItinerariesScreenState();
}

class _SelectedItinerariesScreenState extends State<SelectedItinerariesScreen> {
  late Map<int, String> selectedFareType;
  @override
  void initState() {
    super.initState();
    selectedFareType = Map.fromEntries(widget.selectedItineraries.mapIndexed(
        (idx, itinarary) => MapEntry(idx, itinarary.fare.first.fareType)));
  }

  double totalCost() {
    double totalCost = 0;
    for (var i = 0; i < widget.selectedItineraries.length; i++) {
      var fares = widget.selectedItineraries[i].fare;
      totalCost += fares
          .firstWhere((far) => far.fareType == selectedFareType[i])
          .totalCost;
    }
    return totalCost;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .85,
      child: DefaultTabController(
        length: widget.selectedItineraries.length,
        child: SizedBox(
          child: Stack(
            children: [
              Column(
                children: [
                  const BottomSheetTitleWidget(
                    title: "Flight Details",
                  ),
                  if (widget.selectedItineraries.length > 1)
                    TabBar(
                        dividerColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        indicatorPadding: EdgeInsets.zero,
                        labelPadding: EdgeInsets.zero,
                        onTap: (idx) {},
                        tabs: widget.selectedItineraries.length == 2
                            ? getReturnTabs
                            : widget.selectedItineraries.map((itinerary) {
                                return Tab(
                                    text:
                                        "${itinerary.flightDetailsList.first.fromAirport} - ${itinerary.flightDetailsList.last.toAirport}");
                              }).toList()),
                  if (widget.selectedItineraries.length > 1)
                    SizedBox(
                      height: 16.h,
                    ),
                  Expanded(
                    child: TabBarView(
                        children: widget.selectedItineraries
                            .mapIndexed((idx, itinarary) {
                      return SelectedItineraryDetailScreen(
                          airResponseData: itinarary,
                          onFareChange: (fareType) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(() {
                                selectedFareType[idx] = fareType;
                              });
                            });
                          },
                          airSearch: widget.airSearch);
                    }).toList()),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: 95.h,
                  child: BottomButton(
                      title: "₹ ${totalCost()}",
                      onClick: () {
                        var selectedFares = <int, FareDetailsWithType>{};
                        for (var i = 0;
                            i < widget.selectedItineraries.length;
                            i++) {
                          var itinararyFare = widget.selectedItineraries[i].fare
                              .firstWhere((fare) =>
                                  fare.fareType == selectedFareType[i]);
                          selectedFares[i] = itinararyFare;
                        }
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                            FlightBookingScreen.routeName,
                            arguments: {
                              "airSearch": widget.airSearch,
                              "itineraries": widget.selectedItineraries,
                              "selectedFares": selectedFares
                            });
                      },
                      buttonText: "Book"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> get getReturnTabs {
    return const [
      Tab(
        text: "One Way",
      ),
      Tab(
        text: "Round Trip",
      ),
      // Tab(text: "Multi Trip",),
    ];
  }
}
