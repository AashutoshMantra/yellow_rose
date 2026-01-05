import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yellow_rose/core/common_widgets/base_appbar.dart';
import 'package:yellow_rose/core/common_widgets/button.dart';
import 'package:yellow_rose/core/theme/app_colors.dart';
import 'package:yellow_rose/core/theme/text_styles.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/core/utils/order_invoice_downloader.dart';
import 'package:yellow_rose/core/utils/size_config.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_order_request.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_traveller.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_traveller_detail_count.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_room_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';
import 'package:yellow_rose/features/hotel/domain/usecases/hotel_mapper_utiity.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_card_header.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/common/order_fare_summary.dart';

class HotelBookingDetailScreen extends StatelessWidget {
  static const String routeName = '/hotelBookingDetails';
  final OrderStatus orderStatus;
  final bool readonly;

  const HotelBookingDetailScreen({
    super.key,
    required this.orderStatus,
    this.readonly = false,
  });

  @override
  Widget build(BuildContext context) {
    final booking = orderStatus.hotelBooking;
    final bookingDate = orderStatus.bookingTs ?? orderStatus.creationTs;
    final currency = booking?.hotelBookingRequest?.currency ?? 'INR';
    final totalPaid = booking?.payment?.amount;
    final travellers = booking?.hotelBookingRequest?.travellers
            ?.whereType<HotelTraveler>()
            .toList() ??
        const <HotelTraveler>[];

    return Scaffold(
      appBar: BaseAppBar(
        title: 'Hotel booking',
        subTitle: '',
        shouldHaveRadius: false,
      ),
      bottomNavigationBar: _buildDownloadButton(context),
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
              if (booking == null)
                const _EmptySection(
                  message:
                      'This booking summary is unavailable right now. Please retry later.',
                )
              else ...[
                _HotelOverviewCard(orderStatus: orderStatus),
                SizedBox(height: 16.h),
                _DetailSection(
                  title: 'Stay details',
                  child: _StayDetails(booking: booking),
                ),
                if (travellers.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _DetailSection(
                    title: 'Travellers (${travellers.length})',
                    child: _TravellerList(travellers: travellers),
                  ),
                ],
                if ((booking.hotelBookingRequest?.specialRequest ?? '')
                    .isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _DetailSection(
                    title: 'Special request',
                    child: Text(
                      booking.hotelBookingRequest!.specialRequest!,
                      style: TextStyles.bodyMediumStyle()
                          .copyWith(color: AppColors.primaryTextSwatch[600]),
                    ),
                  ),
                ],
                SizedBox(height: 16.h),
                _DetailSection(
                  title: 'Contact & billing details',
                  child: _ContactDetails(booking: booking),
                ),
                if (totalPaid != null) ...[
                  SizedBox(height: 16.h),
                  _DetailSection(
                    title: 'Payment summary',
                    child: OrderFareSummary(
                      title: 'Total paid',
                      amountText: formatOrderAmount(totalPaid, currency),
                      subtitle: '${currency.toUpperCase()} • Taxes included',
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget? _buildDownloadButton(BuildContext context) {
    final orderId = orderStatus.uuid;
    if (orderId == null ||
        orderStatus.status?.isTicketDownloadable() != true ||
        readonly) {
      return null;
    }
    return Container(
      margin: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 32.h, top: 8.h),
      child: CustomButton(
        text: 'Download voucher',
        onPressed: () => OrderInvoiceDownloader.download(
          context: context,
          orderId: orderId,
        ),
      ),
    );
  }
}

class _HotelOverviewCard extends StatelessWidget {
  final OrderStatus orderStatus;
  const _HotelOverviewCard({required this.orderStatus});

  @override
  Widget build(BuildContext context) {
    final booking = orderStatus.hotelBooking;
    final hotel = booking?.selectedHotelOrder?.hotel;
    final rawImage = (hotel?.mmtMedia?.isNotEmpty ?? false)
        ? hotel!.mmtMedia!.first
        : ((hotel?.agodaMedia?.isNotEmpty ?? false)
            ? hotel!.agodaMedia!.first
            : null);
    final imageUrl = HotelMapperUtiity.getImageUrl(rawImage);
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: Offset(0, 6.h),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.w),
            child: Container(
              width: 96.w,
              height: 96.w,
              color: AppColors.primaryTextSwatch[50],
              child: (imageUrl != null && imageUrl.isNotEmpty)
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Icon(Icons.hotel,
                          color: AppColors.primaryTextSwatch[300], size: 32.w),
                      placeholder: (_, __) => Center(
                        child: SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    )
                  : Icon(Icons.hotel,
                      color: AppColors.primaryTextSwatch[300], size: 32.w),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel?.name ?? 'Hotel',
                  style: TextStyles.bodyLargeBoldStyle(),
                ),
                SizedBox(height: 6.h),
                Text(
                  hotel?.address ?? '-',
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[600]),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10.h),
                Text(
                  _stayLabel(booking?.hotelRequest),
                  style: TextStyles.bodySmallMediumStyle()
                      .copyWith(color: AppColors.primaryTextSwatch[500]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _stayLabel(HotelListSearchRequest? request) {
    if (request == null) return '--';
    return '${CustomDateUtils.dayDateMonthFormat(request.checkInDate)} → ${CustomDateUtils.dayDateMonthFormat(request.checkOutDate)}';
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final Widget child;
  const _DetailSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 12,
            offset: Offset(0, 6.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyles.bodyLargeSemiBoldStyle()),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }
}

class _StayDetails extends StatelessWidget {
  final HotelOrderRequest booking;
  const _StayDetails({required this.booking});

  @override
  Widget build(BuildContext context) {
    final request = booking.hotelRequest;
    final travellerCount = booking.travellerDetails;
    final List<HotelRoomRequest> rooms =
        request?.rooms ?? const <HotelRoomRequest>[];
    return Column(
      children: [
        _KeyValueRow(
          label: 'Dates',
          value:
              '${_formatDate(request?.checkInDate)}  •  ${_formatDate(request?.checkOutDate)}',
        ),
        SizedBox(height: 8.h),
        _KeyValueRow(
          label: 'Nights',
          value: _nightCount(request).toString(),
        ),
        SizedBox(height: 8.h),
        _KeyValueRow(
          label: 'Guests',
          value: _guestCount(travellerCount, request).toString(),
        ),
        if (rooms.isNotEmpty) ...[
          SizedBox(height: 12.h),
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(rooms.length, (index) {
                final room = rooms[index];
                final children = room.childrenAges.length;
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: index == rooms.length - 1 ? 0 : 8.h),
                  child: Text(
                    'Room ${index + 1}: ${room.adults} adult${room.adults == 1 ? '' : 's'}${children > 0 ? ' • $children child${children == 1 ? '' : 'ren'}' : ''}',
                    style: TextStyles.bodySmallMediumStyle()
                        .copyWith(color: AppColors.primaryTextSwatch[600]),
                  ),
                );
              }),
            ),
          )
        ]
      ],
    );
  }

  int _nightCount(HotelListSearchRequest? request) {
    if (request == null) return 0;
    return request.checkOutDate.difference(request.checkInDate).inDays;
  }

  int _guestCount(
    HotelTravellerDetailCount? travellerCount,
    HotelListSearchRequest? request,
  ) {
    if (travellerCount != null) {
      return travellerCount.adult +
          travellerCount.child +
          travellerCount.infantCount;
    }
    if (request != null) {
      int total = 0;
      for (final room in request.rooms) {
        total += room.adults + room.childrenAges.length;
      }
      return total;
    }
    return 0;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '--';
    return CustomDateUtils.dayDateMonthFormat(date);
  }
}

class _TravellerList extends StatelessWidget {
  final List<HotelTraveler> travellers;
  const _TravellerList({required this.travellers});

  @override
  Widget build(BuildContext context) {
    if (travellers.isEmpty) return const SizedBox.shrink();
    return Column(
      children: travellers.asMap().entries.map((entry) {
        final traveller = entry.value;
        return Padding(
          padding: EdgeInsets.only(
              bottom: entry.key == travellers.length - 1 ? 0 : 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundColor: AppColors.primarySwatch[100],
                child: Icon(Icons.person, color: AppColors.primary, size: 18.w),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _travellerName(traveller),
                      style: TextStyles.bodyMediumSemiBoldStyle(),
                    ),
                    if ((traveller.emailId ?? '').isNotEmpty ||
                        (traveller.mobileNo ?? '').isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          _contactLabel(traveller),
                          style: TextStyles.bodySmallMediumStyle().copyWith(
                              color: AppColors.primaryTextSwatch[500]),
                        ),
                      ),
                    if ((traveller.paxType ?? '').isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          traveller.paxType!.toUpperCase(),
                          style: TextStyles.bodySmallMediumStyle().copyWith(
                              color: AppColors.primaryTextSwatch[500]),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _travellerName(HotelTraveler traveller) {
    return [traveller.title, traveller.firstName, traveller.lastName]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join(' ')
        .trim();
  }

  String _contactLabel(HotelTraveler traveller) {
    final parts = <String>[];
    if ((traveller.emailId ?? '').isNotEmpty) parts.add(traveller.emailId!);
    if ((traveller.mobileNo ?? '').isNotEmpty) parts.add(traveller.mobileNo!);
    return parts.join(' • ');
  }
}

class _ContactDetails extends StatelessWidget {
  final HotelOrderRequest booking;
  const _ContactDetails({required this.booking});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _KeyValueRow(
            label: 'Primary contact', value: booking.contactNumber ?? '--'),
        SizedBox(height: 8.h),
        _KeyValueRow(label: 'Email', value: booking.email ?? '--'),
        if ((booking.billingEntity ?? '').isNotEmpty) ...[
          SizedBox(height: 8.h),
          _KeyValueRow(label: 'Billing entity', value: booking.billingEntity!),
        ],
        if ((booking.gstNumber ?? '').isNotEmpty) ...[
          SizedBox(height: 8.h),
          _KeyValueRow(label: 'GST number', value: booking.gstNumber!),
        ],
        if ((booking.gstEmail ?? '').isNotEmpty) ...[
          SizedBox(height: 8.h),
          _KeyValueRow(label: 'GST email', value: booking.gstEmail!),
        ],
      ],
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  const _KeyValueRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyles.bodySmallMediumStyle()
                .copyWith(color: AppColors.primaryTextSwatch[500]),
          ),
        ),
        Text(
          value,
          style: TextStyles.bodySmallSemiBoldStyle(),
          textAlign: TextAlign.right,
        ),
      ],
    );
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
