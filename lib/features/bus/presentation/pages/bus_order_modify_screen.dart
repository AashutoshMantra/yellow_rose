import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/custom_outline_button.dart';
import 'package:yellow_rose/core/common_widgets/loader.dart';
import 'package:yellow_rose/core/common_widgets/popup.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/WidgetUtils.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/bus/presentation/cubit/bus_order_modify/bus_order_modify_cubit.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_journey_timeline.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/presentation/pages/order_status_screen.dart';

class BusOrderModifyScreen extends StatelessWidget {
  static const String routeName = "/busOrderModifyScreen";
  final BusOrderItinerary busOrderItinerary;
  final OrderStatus? orderStatus;

  const BusOrderModifyScreen({
    super.key,
    required this.busOrderItinerary,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    // Filter out cancelled passengers if needed
    var filteredPassengers = busOrderItinerary.busOrderPassengerDetails
            ?.where((element) =>
                element.busBookingStatus != null &&
                !element.busBookingStatus!.isCancelled)
            .toList() ??
        [];

    return Scaffold(
      appBar: BaseAppBar(
        title: "Modify Bus Booking",
        subTitle: "",
        shouldHaveRadius: false,
      ),
      body: BlocListener<BusOrderModifyCubit, BusOrderModifyState>(
        listener: (context, state) {
          if (!state.isLoading && state.errorMessage.isNotEmpty) {
            WidgetUtil.showSnackBar(
                "Error cancelling ticket, try again", context);
            context.read<BusOrderModifyCubit>().clearError();
          }
          if (state.done) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (ctx) {
              return const OrderStatusScreen(
                  orderStatus: OrderStatusEnum.bus_cancel);
            }), (route) {
              return route.settings.name == "/";
            });
          }
        },
        child: BlocBuilder<BusOrderModifyCubit, BusOrderModifyState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryTextSwatch[200]!,
                            ),
                            borderRadius: BorderRadius.circular(8.h),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 12.h),
                            child: Column(
                              children: [
                                // Bus Journey Summary
                                _BusJourneyDetails(
                                  busOrderItinerary: busOrderItinerary,
                                  orderStatus: orderStatus,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 8.h),
                                  child: DottedLine(
                                    alignment: WrapAlignment.center,
                                    dashColor: AppColors.primarySwatch[400]!,
                                  ),
                                ),
                                // Boarding & Dropping Points
                                if (_timelineEntries(
                                        busOrderItinerary.busDetails)
                                    .isNotEmpty) ...[
                                  BusJourneyTimeline(
                                    entries: _timelineEntries(
                                        busOrderItinerary.busDetails),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    child: DottedLine(
                                      alignment: WrapAlignment.center,
                                      dashColor: AppColors.primarySwatch[400]!,
                                    ),
                                  ),
                                ],
                                // Passengers Section
                                Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryGreen,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 8.h),
                                      child: Text("Select Passengers to Cancel",
                                          style:
                                              TextStyles.bodySmallMediumStyle()
                                                  .copyWith(
                                                      color: Colors.white)),
                                    )),
                                SizedBox(height: 8.h),
                                if (filteredPassengers.isEmpty)
                                  Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Text(
                                      "No active passengers available for cancellation",
                                      style: TextStyles.bodyMediumStyle()
                                          .copyWith(
                                              color: AppColors
                                                  .primaryTextSwatch[500]),
                                    ),
                                  )
                                else
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (ctx, idx) {
                                        var passenger = filteredPassengers[idx];
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.h),
                                            color: AppColors.primarySwatch[100],
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Name (${passenger.passengerType?.name ?? 'Passenger'})",
                                                        style: TextStyles
                                                                .bodySmallSemiBoldStyle()
                                                            .copyWith(
                                                                color: AppColors
                                                                        .primaryTextSwatch[
                                                                    500]),
                                                      ),
                                                      SizedBox(height: 4.h),
                                                      Text(
                                                        "${passenger.firstName ?? ''} ${passenger.lastName ?? ''}",
                                                        style: TextStyles
                                                            .bodyMediumBoldStyle(),
                                                      ),
                                                      if (passenger
                                                                  .seatNumber !=
                                                              null &&
                                                          passenger.seatNumber!
                                                              .isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 4.h),
                                                          child: Text(
                                                            "Seat ${passenger.seatNumber}",
                                                            style: TextStyles
                                                                    .bodySmallMediumStyle()
                                                                .copyWith(
                                                                    color: AppColors
                                                                            .primaryTextSwatch[
                                                                        600]),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                                Checkbox(
                                                    value: state
                                                        .selectedPassenger
                                                        .contains(passenger.id),
                                                    onChanged:
                                                        passenger.id != null
                                                            ? (_) {
                                                                context
                                                                    .read<
                                                                        BusOrderModifyCubit>()
                                                                    .togglePassengerSelection(
                                                                        passenger
                                                                            .id!);
                                                              }
                                                            : null)
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (ctx, idx) {
                                        return SizedBox(height: 8.h);
                                      },
                                      itemCount: filteredPassengers.length)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          width: double.infinity,
                          child: CustomOutlinedButton(
                            onPressed: state.selectedPassenger.isEmpty
                                ? null
                                : () {
                                    WidgetUtil.showPopup(context,
                                        icon: Image.asset(
                                          "assets/images/cacel_icon.png",
                                          height: 40.h,
                                        ),
                                        title:
                                            "Are you sure you want to cancel your Bus booking?",
                                        buttons: [
                                          PopupButton(
                                              text: "No",
                                              type: PopupButtonType.secondary,
                                              onPressed: () {}),
                                          PopupButton(
                                              text: "Yes",
                                              onPressed: () async {
                                                await context
                                                    .read<BusOrderModifyCubit>()
                                                    .onCancel();
                                              })
                                        ]);
                                  },
                            text: "Cancel Bus Booking",
                            buttonType: OutlinedButtonType.danger,
                            textStyleOverride: TextStyle(
                                fontWeight:
                                    TextStyles.bodyLargeBoldStyle().fontWeight,
                                fontSize:
                                    TextStyles.bodyLargeBoldStyle().fontSize),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (state.isLoading) const Loader()
              ],
            );
          },
        ),
      ),
    );
  }

  List<BusTimelineEntry> _timelineEntries(busDetails) {
    if (busDetails == null) return const [];
    final boarding = (busDetails.boardingPoint?.isNotEmpty ?? false)
        ? busDetails.boardingPoint!.first
        : null;
    final dropping = (busDetails.droppingPoint?.isNotEmpty ?? false)
        ? busDetails.droppingPoint!.first
        : null;
    final entries = <BusTimelineEntry>[];
    if (boarding != null) {
      entries.add(
        BusTimelineEntry(
          title: 'Boarding',
          location: boarding.location,
          time: _formatTime(boarding.time),
          address: boarding.address,
        ),
      );
    }
    if (dropping != null) {
      entries.add(
        BusTimelineEntry(
          title: 'Dropping',
          location: dropping.location,
          time: _formatTime(dropping.time),
          address: dropping.address,
        ),
      );
    }
    return entries;
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '--';
    return CustomDateUtils.timeInAmPm(dateTime);
  }
}

class _BusJourneyDetails extends StatelessWidget {
  final BusOrderItinerary busOrderItinerary;
  final OrderStatus? orderStatus;

  const _BusJourneyDetails({
    required this.busOrderItinerary,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    final busDetails = busOrderItinerary.busDetails;
    final seats = busDetails?.availableSeats ?? 0;
    final duration = busDetails?.duration ?? '--';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${busDetails?.source ?? '-'} → ${busDetails?.destination ?? '-'}',
                style: TextStyles.bodyLargeBoldStyle(),
              ),
            ),
            if (busOrderItinerary.bookingId != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    busOrderItinerary.bookingStatus?.displayText ??
                        'Status unavailable',
                    style: TextStyles.bodySmallSemiBoldStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[500]),
                  ),
                  Text(
                    'PNR ${busOrderItinerary.bookingId!}',
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[400]),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          '${busDetails?.operatorDetails?.operatorName ?? 'Operator TBD'} • ${busDetails?.busType ?? 'Type not shared'}',
          style: TextStyles.bodySmallMediumStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 8.h,
          children: [
            _Tag(label: 'Duration $duration'),
            _Tag(label: '$seats seats'),
            if (busDetails?.ac == true) const _Tag(label: 'AC coach'),
          ],
        ),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primarySwatch[50],
        borderRadius: BorderRadius.circular(24.w),
      ),
      child: Text(
        label,
        style: TextStyles.bodySmallSemiBoldStyle(),
      ),
    );
  }
}
