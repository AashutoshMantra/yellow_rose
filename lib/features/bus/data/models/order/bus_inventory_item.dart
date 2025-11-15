import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_passenger.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_passenger_gst_details.dart';

class BusInventoryItem {
  final String? seatName;
  final double? fare;
  final String? ladiesSeat;
  final List<BusPassenger>? passenger;
  final List<BusPassengerGSTDetails>? passengerGSTDetails;
  BusInventoryItem({
    this.seatName,
    this.fare,
    this.ladiesSeat,
    this.passenger,
    this.passengerGSTDetails,
  });

  BusInventoryItem copyWith({
    String? seatName,
    double? fare,
    String? ladiesSeat,
    List<BusPassenger>? passenger,
    List<BusPassengerGSTDetails>? passengerGSTDetails,
  }) {
    return BusInventoryItem(
      seatName: seatName ?? this.seatName,
      fare: fare ?? this.fare,
      ladiesSeat: ladiesSeat ?? this.ladiesSeat,
      passenger: passenger ?? this.passenger,
      passengerGSTDetails: passengerGSTDetails ?? this.passengerGSTDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (seatName != null) {
      result.addAll({'seatName': seatName});
    }
    if (fare != null) {
      result.addAll({'fare': fare});
    }
    if (ladiesSeat != null) {
      result.addAll({'ladiesSeat': ladiesSeat});
    }
    if (passenger != null) {
      result.addAll({'passenger': passenger!.map((x) => x?.toMap()).toList()});
    }
    if (passengerGSTDetails != null) {
      result.addAll({
        'passengerGSTDetails':
            passengerGSTDetails!.map((x) => x?.toMap()).toList()
      });
    }

    return result;
  }

  factory BusInventoryItem.fromMap(Map<String, dynamic> map) {
    return BusInventoryItem(
      seatName: map['seatName'],
      fare: map['fare']?.toDouble(),
      ladiesSeat: map['ladiesSeat'],
      passenger: map['passenger'] != null
          ? List<BusPassenger>.from(
              map['passenger']?.map((x) => BusPassenger.fromMap(x)))
          : null,
      passengerGSTDetails: map['passengerGSTDetails'] != null
          ? List<BusPassengerGSTDetails>.from(map['passengerGSTDetails']
              ?.map((x) => BusPassengerGSTDetails.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusInventoryItem.fromJson(String source) =>
      BusInventoryItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'InventoryItem(seatName: $seatName, fare: $fare, ladiesSeat: $ladiesSeat, passenger: $passenger, passengerGSTDetails: $passengerGSTDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusInventoryItem &&
        other.seatName == seatName &&
        other.fare == fare &&
        other.ladiesSeat == ladiesSeat &&
        listEquals(other.passenger, passenger) &&
        listEquals(other.passengerGSTDetails, passengerGSTDetails);
  }

  @override
  int get hashCode {
    return seatName.hashCode ^
        fare.hashCode ^
        ladiesSeat.hashCode ^
        passenger.hashCode ^
        passengerGSTDetails.hashCode;
  }
}
