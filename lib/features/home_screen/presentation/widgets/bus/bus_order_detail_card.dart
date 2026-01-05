import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/bus/presentation/pages/bus_ticket_detail_screen.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_card_header.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_fare_summary.dart';

class BusOrderDetailCard extends StatelessWidget {
  final OrderStatus orderStatus;
  final String? customButtonText;
  final VoidCallback? onCustomButtonPressed;
  final bool readonly;

  const BusOrderDetailCard({
    super.key,
    required this.orderStatus,
    this.customButtonText,
    this.onCustomButtonPressed,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    final itinerary = _resolveItinerary(orderStatus.busOrderItineraries);
    if (itinerary == null) {
      return const SizedBox.shrink();
    }

    final bookingDate = orderStatus.bookingTs ?? orderStatus.creationTs;
    final busDetails = itinerary.busDetails;
    final passengers = itinerary.busOrderPassengerDetails ??
        const <BusOrderPassengerDetails>[];
    final seats = _extractSeatLabels(passengers);
    final boardingPoint = _resolvePoint(busDetails?.boardingPoint);
    final droppingPoint = _resolvePoint(busDetails?.droppingPoint);
    final journeyDate = itinerary.firstDeparture ?? boardingPoint?.time;
    final arrivalTime = droppingPoint?.time;
    final currencyLabel = itinerary.customerPayment.currency ?? 'INR';
    final fare = itinerary.customerPayment.totalBookingAmount;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
            color: AppColors.primaryTextSwatch[200] ?? AppColors.primaryText),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderCardHeader(
            cartId: orderStatus.uuid,
            bookingDate: bookingDate,
            statusText: orderStatus.status?.displayText,
            statusColor: orderStatus.status?.color,
          ),
          Divider(height: 10.h, color: AppColors.primarySwatch[200]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _JourneyHeader(
                  routeLabel: _routeLabel(busDetails),
                  scheduleLabel:
                      _journeyScheduleLabel(journeyDate, arrivalTime),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    _InfoTag(
                      icon: Icons.directions_bus,
                      label: busDetails?.operatorDetails?.operatorName ??
                          'Operator unavailable',
                    ),
                    if ((busDetails?.busType ?? '').isNotEmpty)
                      _InfoTag(
                        icon: Icons.event_seat,
                        label: busDetails!.busType!,
                      ),
                    _InfoTag(
                      icon: Icons.people,
                      label:
                          '${passengers.length} passenger${passengers.length == 1 ? '' : 's'}',
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                _JourneyPointsRow(
                  boarding: _PointDisplay(
                    title: 'Boarding',
                    timeLabel: _formatTime(boardingPoint?.time),
                    location: boardingPoint?.location ?? 'Not assigned',
                    address: boardingPoint?.address,
                  ),
                  dropping: _PointDisplay(
                    title: 'Dropping',
                    timeLabel: _formatTime(droppingPoint?.time),
                    location: droppingPoint?.location ?? 'Not assigned',
                    address: droppingPoint?.address,
                  ),
                ),
                if (seats.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  Text(
                    'Seats (${seats.length})',
                    style: TextStyles.bodySmallSemiBoldStyle(),
                  ),
                  SizedBox(height: 6.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: seats
                        .map(
                          (seat) => Chip(
                            padding: EdgeInsets.zero,
                            backgroundColor: AppColors.primarySwatch[50],
                            label: Text(
                              seat,
                              style: TextStyles.bodySmallBoldStyle(),
                            ),
                            visualDensity: const VisualDensity(
                                horizontal: -2, vertical: -2),
                          ),
                        )
                        .toList(),
                  ),
                ],
                SizedBox(height: 14.h),
                OrderFareSummary(
                  title: 'Total paid',
                  amountText: formatOrderAmount(fare, currencyLabel),
                  subtitle: '${currencyLabel.toUpperCase()} • Taxes included',
                ),
                SizedBox(height: 16.h),
                customButtonText != null && onCustomButtonPressed != null
                    ? CustomButton(
                        text: customButtonText!,
                        onPressed: onCustomButtonPressed!,
                      )
                    : CustomButton(
                        text: 'View ticket',
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            BusTicketDetailScreen.routeName,
                            arguments: {
                              'orderStatus': orderStatus,
                              'readonly': readonly,
                            },
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  BusOrderItinerary? _resolveItinerary(List<BusOrderItinerary>? itineraries) {
    if (itineraries == null || itineraries.isEmpty) return null;
    return itineraries.first;
  }

  List<String> _extractSeatLabels(List<BusOrderPassengerDetails> passengers) {
    final seats = passengers
        .map((p) => p.seatNumber?.trim())
        .whereType<String>()
        .where((seat) => seat.isNotEmpty)
        .toList();
    seats.sort();
    return seats;
  }

  BusPoint? _resolvePoint(List<BusPoint>? points) {
    if (points == null || points.isEmpty) return null;
    return points.first;
  }

  String _routeLabel(UserBusBookingRequest? details) {
    final from = details?.source ?? '-';
    final to = details?.destination ?? '-';
    return '$from → $to';
  }

  String _journeyScheduleLabel(DateTime? departure, DateTime? arrival) {
    if (departure == null && arrival == null) {
      return 'Schedule not available';
    }
    final date = _formatDate(departure ?? arrival);
    final dep = _formatTime(departure);
    final arr = _formatTime(arrival);
    if (arrival == null) {
      return '$date • $dep';
    }
    return '$date • $dep - $arr';
  }

  String _formatDate(DateTime? value) {
    if (value == null) return '--';
    return CustomDateUtils.dayDateMonthFormat(value);
  }

  String _formatTime(DateTime? value) {
    if (value == null) return '--';
    return CustomDateUtils.timeInAmPm(value);
  }
}

class _JourneyHeader extends StatelessWidget {
  final String routeLabel;
  final String scheduleLabel;
  const _JourneyHeader({required this.routeLabel, required this.scheduleLabel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          routeLabel,
          style: TextStyles.bodyLargeBoldStyle(),
        ),
        SizedBox(height: 4.h),
        Text(
          scheduleLabel,
          style: TextStyles.bodySmallMediumStyle()
              .copyWith(color: AppColors.primaryTextSwatch[600]),
        ),
      ],
    );
  }
}

class _InfoTag extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTag({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.primarySwatch[50],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w, color: AppColors.primary),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyles.bodySmallSemiBoldStyle(),
          ),
        ],
      ),
    );
  }
}

class _PointDisplay {
  final String title;
  final String timeLabel;
  final String location;
  final String? address;
  const _PointDisplay({
    required this.title,
    required this.timeLabel,
    required this.location,
    this.address,
  });
}

class _JourneyPointsRow extends StatelessWidget {
  final _PointDisplay boarding;
  final _PointDisplay dropping;
  const _JourneyPointsRow({required this.boarding, required this.dropping});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _CompactPointCard(display: boarding)),
        SizedBox(width: 12.w),
        Expanded(child: _CompactPointCard(display: dropping)),
      ],
    );
  }
}

class _CompactPointCard extends StatelessWidget {
  final _PointDisplay display;
  const _CompactPointCard({required this.display});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          display.title,
          style: TextStyles.bodySmallSemiBoldStyle()
              .copyWith(color: AppColors.primaryTextSwatch[500]),
        ),
        SizedBox(height: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColors.primarySwatch[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                display.title == 'Boarding'
                    ? Icons.arrow_circle_up
                    : Icons.arrow_circle_down,
                color: AppColors.primary,
                size: 16.w,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    display.timeLabel,
                    style: TextStyles.bodyMediumBoldStyle(),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    display.location,
                    style: TextStyles.bodySmallMediumStyle(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if ((display.address ?? '').isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    Text(
                      display.address!,
                      style: TextStyles.bodySmallMediumStyle().copyWith(
                        color: AppColors.primaryTextSwatch[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
