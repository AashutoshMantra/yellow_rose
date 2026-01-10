import 'package:flutter/material.dart';
import 'package:yellow_rose/core/constants/supported_service.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/order_status.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/air/air_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/bus/bus_order_detail_card.dart';
import 'package:yellow_rose/features/home_screen/presentation/widgets/hotel/hotel_order_detail_card.dart';
import 'package:yellow_rose/features/trip/data/models/trip_item.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';
import 'package:yellow_rose/features/trip/data/models/trip_status_enum.dart';

class TripServiceCard extends StatelessWidget {
  final TripAirItem item;
  final OrderStatus order;
  final TripResponse trip;
  final bool isTeamTrip;
  final Function(SupportedService) onModify;

  const TripServiceCard({
    super.key,
    required this.item,
    required this.order,
    required this.trip,
    required this.isTeamTrip,
    required this.onModify,
  });

  @override
  Widget build(BuildContext context) {
    final productType = item.type;
    final isNewStatus =
        trip.status == TripStatusEnum.NEW || trip.status?.code == 'N';

    final showModifyButton = !isTeamTrip && isNewStatus;

    switch (productType) {
      case ProductTypeEnum.AIR:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () => onModify(SupportedService.Flights),
          readonly: isTeamTrip,
        );
      case ProductTypeEnum.HOTEL:
        return HotelOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () => onModify(SupportedService.Hotels),
          readonly: isTeamTrip,
        );
      case ProductTypeEnum.BUS:
        return BusOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton ? null : () {},
          readonly: isTeamTrip,
        );
      default:
        return AirOrderDetailCard(
          orderStatus: order,
          customButtonText: !showModifyButton ? null : 'Modify',
          onCustomButtonPressed: !showModifyButton
              ? null
              : () => onModify(SupportedService.Flights),
          readonly: isTeamTrip,
        );
    }
  }
}
