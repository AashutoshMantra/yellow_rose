import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_order_itinerary.dart';

class BusOrderResDetails {
  final String? orderId;
  final List<BusOrderItinerary>? itineraries;
  // final BookingOrder? bookingOrder;
  final List<BusOrderPassengerDetails>? passengerDetails;
  BusOrderResDetails({
    this.orderId,
    this.itineraries,
    this.passengerDetails,
  });

  BusOrderResDetails copyWith({
    String? orderId,
    List<BusOrderItinerary>? itineraries,
    List<BusOrderPassengerDetails>? passengerDetails,
  }) {
    return BusOrderResDetails(
      orderId: orderId ?? this.orderId,
      itineraries: itineraries ?? this.itineraries,
      passengerDetails: passengerDetails ?? this.passengerDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (itineraries != null) {
      result
          .addAll({'itineraries': itineraries!.map((x) => x.toMap()).toList()});
    }
    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory BusOrderResDetails.fromMap(Map<String, dynamic> map) {
    return BusOrderResDetails(
      orderId: map['orderId'],
      itineraries: map['itineraries'] != null
          ? List<BusOrderItinerary>.from(
              map['itineraries']?.map((x) => BusOrderItinerary.fromMap(x)))
          : null,
      passengerDetails: map['passengerDetails'] != null
          ? List<BusOrderPassengerDetails>.from(map['passengerDetails']
              ?.map((x) => BusOrderPassengerDetails.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderResDetails.fromJson(String source) =>
      BusOrderResDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'BusOrderResDetails(orderId: $orderId, itineraries: $itineraries, passengerDetails: $passengerDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderResDetails &&
        other.orderId == orderId &&
        listEquals(other.itineraries, itineraries) &&
        listEquals(other.passengerDetails, passengerDetails);
  }

  @override
  int get hashCode =>
      orderId.hashCode ^ itineraries.hashCode ^ passengerDetails.hashCode;
}
