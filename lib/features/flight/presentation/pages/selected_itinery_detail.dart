import 'package:flutter/material.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/fare_info_widget.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/flight_detail_card.dart';
import 'package:yellow_rose/features/flight/presentation/widgets/itineray_detail_card.dart';

class SelectedItineraryDetailScreen extends StatefulWidget {
  final AirResponseData airResponseData;
  final AirSearch airSearch;
  final Function(String) onFareChange;
  const SelectedItineraryDetailScreen(
      {super.key,
      required this.airResponseData,
      required this.airSearch,
      required this.onFareChange});

  @override
  State<SelectedItineraryDetailScreen> createState() =>
      _SelectedItineraryDetailScreenState();
}

class _SelectedItineraryDetailScreenState
    extends State<SelectedItineraryDetailScreen>
    with AutomaticKeepAliveClientMixin {
  late String _selectedFare;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _fareInfoKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _selectedFare = widget.airResponseData.fare.first.fareType;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToFareSection();
    });
  }

  void _scrollToFareSection() {
    Future.delayed(const Duration(milliseconds: 300), () {
      RenderBox? fareBox =
          _fareInfoKey.currentContext?.findRenderObject() as RenderBox?;

      if (fareBox != null) {
        double farePosition = fareBox
            .localToGlobal(Offset.zero, ancestor: context.findRenderObject())
            .dy;

        double scrollOffset = _scrollController.offset + farePosition - 50;

        _scrollController.animateTo(
          scrollOffset.clamp(
            _scrollController.position.minScrollExtent,
            _scrollController.position.maxScrollExtent,
          ),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );

        // Scroll back after delay
        Future.delayed(const Duration(milliseconds: 700), () {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.onFareChange(_selectedFare);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
                color: AppColors.primarySwatch[50],
                border: Border.all(color: AppColors.primarySwatch[300]!),
                borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.0.h),
              child: Column(
                children: [
                  Text(
                    "${widget.airResponseData.flightDetailsList.first.fromAirport} - ${widget.airResponseData.flightDetailsList.last.toAirport}",
                    style: TextStyles.bodyMediumBoldStyle(),
                  ),
                  Text(
                    "${getStopText(widget.airResponseData)}, ${CustomDateUtils.durationToString(widget.airResponseData.travelDuration ?? 0)}, ${widget.airSearch.searchClass!.text}",
                    style: TextStyles.bodyMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scrollController,
              children: [
                SizedBox(
                  height: 12.h,
                ),
                ...(widget.airResponseData.flightDetailsList.map((flight) {
                  return Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      child: FlightDetailCard(sourceFLight: flight));
                }).toList()),
                SizedBox(
                  height: 18.h,
                ),
                Container(
                  key: _fareInfoKey, // Assign key to this section
                  child: Column(
                    children: widget.airResponseData.fare.map((fare) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        child: FareInfoWidget(
                          fareDetail: fare,
                          onSelect: (fareDetail) {
                            setState(() {
                              _selectedFare = fareDetail.fareType;
                            });
                          },
                          isSelected: _selectedFare == fare.fareType,
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 32.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
