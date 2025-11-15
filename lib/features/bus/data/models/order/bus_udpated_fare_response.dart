import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_udpated_fare_breakup.dart';

class BusUpdatedFareRes {
  final int? fareDifference;
  final int? convenienceFee;
  final int? otherCharges;
  final int? previousFare;
  final int? reservationCharges;
  final int? updatedFare;
  final List<BusUpdatedFareBreakup>? fareBreakup;
  BusUpdatedFareRes({
    this.fareDifference,
    this.convenienceFee,
    this.otherCharges,
    this.previousFare,
    this.reservationCharges,
    this.updatedFare,
    this.fareBreakup,
  });

  BusUpdatedFareRes copyWith({
    int? fareDifference,
    int? convenienceFee,
    int? otherCharges,
    int? previousFare,
    int? reservationCharges,
    int? updatedFare,
    List<BusUpdatedFareBreakup>? fareBreakup,
  }) {
    return BusUpdatedFareRes(
      fareDifference: fareDifference ?? this.fareDifference,
      convenienceFee: convenienceFee ?? this.convenienceFee,
      otherCharges: otherCharges ?? this.otherCharges,
      previousFare: previousFare ?? this.previousFare,
      reservationCharges: reservationCharges ?? this.reservationCharges,
      updatedFare: updatedFare ?? this.updatedFare,
      fareBreakup: fareBreakup ?? this.fareBreakup,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (fareDifference != null) {
      result.addAll({'fareDifference': fareDifference});
    }
    if (convenienceFee != null) {
      result.addAll({'convenienceFee': convenienceFee});
    }
    if (otherCharges != null) {
      result.addAll({'otherCharges': otherCharges});
    }
    if (previousFare != null) {
      result.addAll({'previousFare': previousFare});
    }
    if (reservationCharges != null) {
      result.addAll({'reservationCharges': reservationCharges});
    }
    if (updatedFare != null) {
      result.addAll({'updatedFare': updatedFare});
    }
    if (fareBreakup != null) {
      result
          .addAll({'fareBreakup': fareBreakup!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory BusUpdatedFareRes.fromMap(Map<String, dynamic> map) {
    return BusUpdatedFareRes(
      fareDifference: map['fareDifference']?.toInt(),
      convenienceFee: map['convenienceFee']?.toInt(),
      otherCharges: map['otherCharges']?.toInt(),
      previousFare: map['previousFare']?.toInt(),
      reservationCharges: map['reservationCharges']?.toInt(),
      updatedFare: map['updatedFare']?.toInt(),
      fareBreakup: map['fareBreakup'] != null
          ? List<BusUpdatedFareBreakup>.from(
              map['fareBreakup']?.map((x) => BusUpdatedFareBreakup.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusUpdatedFareRes.fromJson(String source) =>
      BusUpdatedFareRes.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpdatedFareRes(fareDifference: $fareDifference, convenienceFee: $convenienceFee, otherCharges: $otherCharges, previousFare: $previousFare, reservationCharges: $reservationCharges, updatedFare: $updatedFare, fareBreakup: $fareBreakup)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusUpdatedFareRes &&
        other.fareDifference == fareDifference &&
        other.convenienceFee == convenienceFee &&
        other.otherCharges == otherCharges &&
        other.previousFare == previousFare &&
        other.reservationCharges == reservationCharges &&
        other.updatedFare == updatedFare &&
        listEquals(other.fareBreakup, fareBreakup);
  }

  @override
  int get hashCode {
    return fareDifference.hashCode ^
        convenienceFee.hashCode ^
        otherCharges.hashCode ^
        previousFare.hashCode ^
        reservationCharges.hashCode ^
        updatedFare.hashCode ^
        fareBreakup.hashCode;
  }
}
