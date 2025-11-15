import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'package:yellow_rose/features/bus/data/models/bus_fare.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';

class BusDetailResponse {
  final String? availableSeats;
  final List<BusPoint> boardingPoint;
  final List<BusPoint> droppingPoint;
  final List<BusFare> fare;
  final String? maxSeatsPerTicket;
  final String? primo;
  final List<BusSeats> seats;
  final bool? callFareBreakUpAPI;
  BusDetailResponse({
    this.availableSeats,
    required this.boardingPoint,
    required this.droppingPoint,
    required this.fare,
    this.maxSeatsPerTicket,
    this.primo,
    required this.seats,
    this.callFareBreakUpAPI,
  });

  BusDetailResponse copyWith({
    String? availableSeats,
    List<BusPoint>? boardingPoint,
    List<BusPoint>? droppingPoint,
    List<BusFare>? fare,
    String? maxSeatsPerTicket,
    String? primo,
    List<BusSeats>? seats,
    bool? callFareBreakUpAPI,
  }) {
    return BusDetailResponse(
      availableSeats: availableSeats ?? this.availableSeats,
      boardingPoint: boardingPoint ?? this.boardingPoint,
      droppingPoint: droppingPoint ?? this.droppingPoint,
      fare: fare ?? this.fare,
      maxSeatsPerTicket: maxSeatsPerTicket ?? this.maxSeatsPerTicket,
      primo: primo ?? this.primo,
      seats: seats ?? this.seats,
      callFareBreakUpAPI: callFareBreakUpAPI ?? this.callFareBreakUpAPI,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (availableSeats != null) {
      result.addAll({'availableSeats': availableSeats});
    }
    result.addAll(
        {'boardingPoint': boardingPoint.map((x) => x.toMap()).toList()});
    result.addAll(
        {'droppingPoint': droppingPoint.map((x) => x.toMap()).toList()});
    result.addAll({'fare': fare.map((x) => x.toMap()).toList()});
    if (maxSeatsPerTicket != null) {
      result.addAll({'maxSeatsPerTicket': maxSeatsPerTicket});
    }
    if (primo != null) {
      result.addAll({'primo': primo});
    }
    result.addAll({'seats': seats.map((x) => x.toMap()).toList()});
    if (callFareBreakUpAPI != null) {
      result.addAll({'callFareBreakUpAPI': callFareBreakUpAPI});
    }

    return result;
  }

  factory BusDetailResponse.fromMap(Map<String, dynamic> map) {
    return BusDetailResponse(
      availableSeats: map['availableSeats'],
      boardingPoint: List<BusPoint>.from(
          map['boardingPoint']?.map((x) => BusPoint.fromMap(x))),
      droppingPoint: List<BusPoint>.from(
          map['droppingPoint']?.map((x) => BusPoint.fromMap(x))),
      fare: List<BusFare>.from(map['fare']?.map((x) => BusFare.fromMap(x))),
      maxSeatsPerTicket: map['maxSeatsPerTicket'],
      primo: map['primo'],
      seats: List<BusSeats>.from(map['seats']?.map((x) => BusSeats.fromMap(x))),
      callFareBreakUpAPI: map['callFareBreakUpAPI'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusDetailResponse.fromJson(String source) =>
      BusDetailResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusDetailResponse(availableSeats: $availableSeats, boardingPoint: $boardingPoint, droppingPoint: $droppingPoint, fare: $fare, maxSeatsPerTicket: $maxSeatsPerTicket, primo: $primo, seats: $seats, callFareBreakUpAPI: $callFareBreakUpAPI)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusDetailResponse &&
        other.availableSeats == availableSeats &&
        listEquals(other.boardingPoint, boardingPoint) &&
        listEquals(other.droppingPoint, droppingPoint) &&
        listEquals(other.fare, fare) &&
        other.maxSeatsPerTicket == maxSeatsPerTicket &&
        other.primo == primo &&
        listEquals(other.seats, seats) &&
        other.callFareBreakUpAPI == callFareBreakUpAPI;
  }

  @override
  int get hashCode {
    return availableSeats.hashCode ^
        boardingPoint.hashCode ^
        droppingPoint.hashCode ^
        fare.hashCode ^
        maxSeatsPerTicket.hashCode ^
        primo.hashCode ^
        seats.hashCode ^
        callFareBreakUpAPI.hashCode;
  }
}
