import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/order_invoice_downloader.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_journey_timeline.dart';
import 'package:yellow_rose/features/bus/presentation/widgets/bus_section_card.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_card_header.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_fare_summary.dart';

class BusTicketDetailScreen extends StatelessWidget {
  static const String routeName = '/busTicketDetails';
  final OrderStatus orderStatus;

  const BusTicketDetailScreen({super.key, required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    final itinerary = _primaryItinerary(orderStatus.busOrderItineraries);
    final bookingDate = orderStatus.bookingTs ?? orderStatus.creationTs;
    final currency = itinerary?.customerPayment.currency ?? 'INR';
    final fare = itinerary?.customerPayment.totalBookingAmount;

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Bus ticket',
        subTitle: '',
        shouldHaveRadius: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OrderCardHeader(
                cartId: orderStatus.uuid,
                bookingDate: bookingDate,
                statusText: orderStatus.status?.displayText,
                statusColor: orderStatus.status?.color,
              ),
              SizedBox(height: 16.h),
              if (itinerary == null)
                const _EmptySection(
                  message:
                      'No itinerary information was found for this booking. Please contact support.',
                )
              else ...[
                BusSectionCard(
                  title: 'Journey summary',
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        itinerary.bookingStatus ?? 'Status unavailable',
                        style: TextStyles.bodySmallSemiBoldStyle()
                            .copyWith(color: AppColors.primaryTextSwatch[500]),
                      ),
                      if (itinerary.bookingId != null)
                        Text(
                          'PNR ${itinerary.bookingId!}',
                          style: TextStyles.bodySmallMediumStyle().copyWith(
                              color: AppColors.primaryTextSwatch[400]),
                        ),
                    ],
                  ),
                  child: _JourneySummary(busDetails: itinerary.busDetails),
                ),
                SizedBox(height: 16.h),
                if (_timelineEntries(itinerary.busDetails).isNotEmpty)
                  BusSectionCard(
                    title: 'Boarding & drop-off',
                    child: BusJourneyTimeline(
                      entries: _timelineEntries(itinerary.busDetails),
                    ),
                  ),
                SizedBox(height: 16.h),
                if (itinerary.busOrderPassengerDetails?.isNotEmpty ?? false)
                  BusSectionCard(
                    title:
                        'Passengers (${itinerary.busOrderPassengerDetails!.length})',
                    child: _PassengerList(
                      passengers: itinerary.busOrderPassengerDetails!,
                    ),
                  ),
                SizedBox(height: 16.h),
                if (fare != null)
                  BusSectionCard(
                    title: 'Payment summary',
                    child: OrderFareSummary(
                      title: 'Total paid',
                      amountText: formatOrderAmount(fare, currency),
                      subtitle: '${currency.toUpperCase()} • Taxes included',
                    ),
                  ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildDownloadButton(BuildContext context) {
    final orderId = orderStatus.uuid;
    if (orderId == null || orderStatus.status?.isTicketDownloadable() != true) {
      return null;
    }
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h, top: 8.h),
      child: CustomButton(
        text: 'Download ticket',
        onPressed: () => OrderInvoiceDownloader.download(
          context: context,
          orderId: orderId,
        ),
      ),
    );
  }

  BusOrderItinerary? _primaryItinerary(List<BusOrderItinerary>? itineraries) {
    if (itineraries == null || itineraries.isEmpty) return null;
    return itineraries.first;
  }

  List<BusTimelineEntry> _timelineEntries(UserBusBookingRequest? details) {
    if (details == null) return const [];
    final boarding = (details.boardingPoint?.isNotEmpty ?? false)
        ? details.boardingPoint!.first
        : null;
    final dropping = (details.droppingPoint?.isNotEmpty ?? false)
        ? details.droppingPoint!.first
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

class _JourneySummary extends StatelessWidget {
  final UserBusBookingRequest? busDetails;
  const _JourneySummary({required this.busDetails});

  @override
  Widget build(BuildContext context) {
    final seats = busDetails?.availableSeats ?? 0;
    final duration = busDetails?.duration ?? '--';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${busDetails?.source ?? '-'} → ${busDetails?.destination ?? '-'}',
          style: TextStyles.bodyLargeBoldStyle(),
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
            _Tag(label: '$seats seats left'),
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

class _PassengerList extends StatelessWidget {
  final List<BusOrderPassengerDetails> passengers;
  const _PassengerList({required this.passengers});

  @override
  Widget build(BuildContext context) {
    final seatLabels = passengers
        .map((p) => p.seatNumber?.trim())
        .whereType<String>()
        .where((seat) => seat.isNotEmpty)
        .toList()
      ..sort();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (seatLabels.isNotEmpty) ...[
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: seatLabels
                .map((label) => Chip(
                      label: Text('Seat $label'),
                      backgroundColor: AppColors.primarySwatch[50],
                    ))
                .toList(),
          ),
          SizedBox(height: 12.h),
        ],
        ...passengers.asMap().entries.map((entry) {
          final passenger = entry.value;
          return Padding(
            padding: EdgeInsets.only(
                bottom: entry.key == passengers.length - 1 ? 0 : 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _passengerName(passenger),
                  style: TextStyles.bodyMediumSemiBoldStyle(),
                ),
                SizedBox(height: 4.h),
                Text(
                  _passengerMeta(passenger),
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                ),
                if ((passenger.ticketNumber ?? '').isNotEmpty)
                  Text(
                    'Ticket ${passenger.ticketNumber}',
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[500]),
                  ),
                if (entry.key != passengers.length - 1)
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Divider(
                        height: 1, color: AppColors.primaryTextSwatch[100]),
                  ),
              ],
            ),
          );
        })
      ],
    );
  }

  String _passengerName(BusOrderPassengerDetails passenger) {
    return [passenger.title, passenger.firstName, passenger.lastName]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join(' ')
        .trim();
  }

  String _passengerMeta(BusOrderPassengerDetails passenger) {
    final parts = <String>[];
    if ((passenger.gender ?? '').isNotEmpty) parts.add(passenger.gender!);
    if ((passenger.seatNumber ?? '').isNotEmpty) {
      parts.add('Seat ${passenger.seatNumber}');
    }
    return parts.isEmpty ? 'Details unavailable' : parts.join(' • ');
  }
}

class _EmptySection extends StatelessWidget {
  final String message;
  const _EmptySection({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.w),
        color: AppColors.primarySwatch[50],
      ),
      child: Text(
        message,
        style: TextStyles.bodyMediumStyle()
            .copyWith(color: AppColors.primaryTextSwatch[600]),
      ),
    );
  }
}
