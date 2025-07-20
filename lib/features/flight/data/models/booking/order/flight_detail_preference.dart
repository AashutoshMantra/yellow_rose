import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/passport_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/ssr_options.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_visa_details.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';

class FlightDetailsWithPassengerPreferences {
  final AirSeat? seat;
  final List<SSROptions>? ssrOptionsList;
  final String? loyaltyNumber;
  final UserVisaDetails? visaDetails;
  final UserPassportDetails? passportDetails;

  final String? carrierName;
  final String? carrierFullName;
  final String? carrierPlaneCode;
  final String? fromCity;
  final String? toCity;
  final String? flightNumber;
  final String? fromAirport;
  final String? toAirport;
  final String? fromTerminal;
  final String? toTerminal;
  final String? segmentKey;
  final String? flightId;
  final String? trackId;
  final DateTime? schDepartureTime;
  final DateTime? schArrivalTime;
  final bool? layOver;
  final String? displaySchDepartureTime;
  final String displaySchArrivalTime;

  final int? travelDuration;
  final String? travelDurationHrs;
  final String? layOffDuration;
  final String? equipmentType;
  final Map<String, Object>? otherData;
  final String? distance;
  final String? unit;
  FlightDetailsWithPassengerPreferences({
    this.seat,
    this.ssrOptionsList,
    this.loyaltyNumber,
    this.visaDetails,
    this.passportDetails,
    this.carrierName,
    this.carrierFullName,
    this.carrierPlaneCode,
    this.fromCity,
    this.toCity,
    this.flightNumber,
    this.fromAirport,
    this.toAirport,
    this.fromTerminal,
    this.toTerminal,
    this.segmentKey,
    this.flightId,
    this.trackId,
    this.schDepartureTime,
    this.schArrivalTime,
    this.layOver,
    this.displaySchDepartureTime,
    required this.displaySchArrivalTime,
    this.travelDuration,
    this.travelDurationHrs,
    this.layOffDuration,
    this.equipmentType,
    this.otherData,
    this.distance,
    this.unit,
  });

  FlightDetailsWithPassengerPreferences copyWith({
    AirSeat? seat,
    List<SSROptions>? ssrOptionsList,
    String? loyaltyNumber,
    UserVisaDetails? visaDetails,
    UserPassportDetails? passportDetails,
    String? carrierName,
    String? carrierFullName,
    String? carrierPlaneCode,
    String? fromCity,
    String? toCity,
    String? flightNumber,
    String? fromAirport,
    String? toAirport,
    String? fromTerminal,
    String? toTerminal,
    String? segmentKey,
    String? flightId,
    String? trackId,
    DateTime? schDepartureTime,
    DateTime? schArrivalTime,
    bool? layOver,
    String? displaySchDepartureTime,
    String? displaySchArrivalTime,
    int? travelDuration,
    String? travelDurationHrs,
    String? layOffDuration,
    String? equipmentType,
    Map<String, Object>? otherData,
    String? distance,
    String? unit,
  }) {
    return FlightDetailsWithPassengerPreferences(
      seat: seat ?? this.seat,
      ssrOptionsList: ssrOptionsList ?? this.ssrOptionsList,
      loyaltyNumber: loyaltyNumber ?? this.loyaltyNumber,
      visaDetails: visaDetails ?? this.visaDetails,
      passportDetails: passportDetails ?? this.passportDetails,
      carrierName: carrierName ?? this.carrierName,
      carrierFullName: carrierFullName ?? this.carrierFullName,
      carrierPlaneCode: carrierPlaneCode ?? this.carrierPlaneCode,
      fromCity: fromCity ?? this.fromCity,
      toCity: toCity ?? this.toCity,
      flightNumber: flightNumber ?? this.flightNumber,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      fromTerminal: fromTerminal ?? this.fromTerminal,
      toTerminal: toTerminal ?? this.toTerminal,
      segmentKey: segmentKey ?? this.segmentKey,
      flightId: flightId ?? this.flightId,
      trackId: trackId ?? this.trackId,
      schDepartureTime: schDepartureTime ?? this.schDepartureTime,
      schArrivalTime: schArrivalTime ?? this.schArrivalTime,
      layOver: layOver ?? this.layOver,
      displaySchDepartureTime:
          displaySchDepartureTime ?? this.displaySchDepartureTime,
      displaySchArrivalTime:
          displaySchArrivalTime ?? this.displaySchArrivalTime,
      travelDuration: travelDuration ?? this.travelDuration,
      travelDurationHrs: travelDurationHrs ?? this.travelDurationHrs,
      layOffDuration: layOffDuration ?? this.layOffDuration,
      equipmentType: equipmentType ?? this.equipmentType,
      otherData: otherData ?? this.otherData,
      distance: distance ?? this.distance,
      unit: unit ?? this.unit,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (seat != null) {
      result.addAll({'seat': seat!.toMap()});
    }
    if (ssrOptionsList != null) {
      result.addAll(
          {'ssrOptionsList': ssrOptionsList!.map((x) => x.toMap()).toList()});
    }
    if (loyaltyNumber != null) {
      result.addAll({'loyaltyNumber': loyaltyNumber});
    }
    if (visaDetails != null) {
      result.addAll({'visaDetails': visaDetails!.toMap()});
    }
    if (passportDetails != null) {
      result.addAll({'passportDetails': passportDetails!.toMap()});
    }
    if (carrierName != null) {
      result.addAll({'carrierName': carrierName});
    }
    if (carrierFullName != null) {
      result.addAll({'carrierFullName': carrierFullName});
    }
    if (carrierPlaneCode != null) {
      result.addAll({'carrierPlaneCode': carrierPlaneCode});
    }
    if (fromCity != null) {
      result.addAll({'fromCity': fromCity});
    }
    if (toCity != null) {
      result.addAll({'toCity': toCity});
    }
    if (flightNumber != null) {
      result.addAll({'flightNumber': flightNumber});
    }
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }
    if (fromTerminal != null) {
      result.addAll({'fromTerminal': fromTerminal});
    }
    if (toTerminal != null) {
      result.addAll({'toTerminal': toTerminal});
    }
    if (segmentKey != null) {
      result.addAll({'segmentKey': segmentKey});
    }
    if (flightId != null) {
      result.addAll({'flightId': flightId});
    }
    if (trackId != null) {
      result.addAll({'trackId': trackId});
    }
    if (schDepartureTime != null) {
      result.addAll(
          {'schDepartureTime': schDepartureTime!.millisecondsSinceEpoch});
    }
    if (schArrivalTime != null) {
      result.addAll({'schArrivalTime': schArrivalTime!.millisecondsSinceEpoch});
    }
    if (layOver != null) {
      result.addAll({'layOver': layOver});
    }
    if (displaySchDepartureTime != null) {
      result.addAll({'displaySchDepartureTime': displaySchDepartureTime});
    }
    result.addAll({'displaySchArrivalTime': displaySchArrivalTime});
    if (travelDuration != null) {
      result.addAll({'travelDuration': travelDuration});
    }
    if (travelDurationHrs != null) {
      result.addAll({'travelDurationHrs': travelDurationHrs});
    }
    if (layOffDuration != null) {
      result.addAll({'layOffDuration': layOffDuration});
    }
    if (equipmentType != null) {
      result.addAll({'equipmentType': equipmentType});
    }
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (distance != null) {
      result.addAll({'distance': distance});
    }
    if (unit != null) {
      result.addAll({'unit': unit});
    }

    return result;
  }

  factory FlightDetailsWithPassengerPreferences.fromMap(
      Map<String, dynamic> map) {
    return FlightDetailsWithPassengerPreferences(
      seat: map['seat'] != null ? AirSeat.fromMap(map['seat']) : null,
      ssrOptionsList: map['ssrOptionsList'] != null
          ? List<SSROptions>.from(
              map['ssrOptionsList']?.map((x) => SSROptions.fromMap(x)))
          : null,
      loyaltyNumber: map['loyaltyNumber'],
      visaDetails: map['visaDetails'] != null
          ? UserVisaDetails.fromMap(map['visaDetails'])
          : null,
      passportDetails: map['passportDetails'] != null
          ? UserPassportDetails.fromMap(map['passportDetails'])
          : null,
      carrierName: map['carrierName'],
      carrierFullName: map['carrierFullName'],
      carrierPlaneCode: map['carrierPlaneCode'],
      fromCity: map['fromCity'],
      toCity: map['toCity'],
      flightNumber: map['flightNumber'],
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      fromTerminal: map['fromTerminal'],
      toTerminal: map['toTerminal'],
      segmentKey: map['segmentKey'],
      flightId: map['flightId'],
      trackId: map['trackId'],
      schDepartureTime: map['schDepartureTime'] != null
          ? DateTime.tryParse(map['schDepartureTime'])
          : null,
      schArrivalTime: map['schArrivalTime'] != null
          ? DateTime.tryParse(map['schArrivalTime'])
          : null,
      layOver: map['layOver'],
      displaySchDepartureTime: map['displaySchDepartureTime'],
      displaySchArrivalTime: map['displaySchArrivalTime'] ?? '',
      travelDuration: map['travelDuration']?.toInt(),
      travelDurationHrs: map['travelDurationHrs'],
      layOffDuration: map['layOffDuration'],
      equipmentType: map['equipmentType'],
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      distance: map['distance'],
      unit: map['unit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlightDetailsWithPassengerPreferences.fromJson(String source) =>
      FlightDetailsWithPassengerPreferences.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlightDetailsWithPassengerPreferences(seat: $seat, ssrOptionsList: $ssrOptionsList, loyaltyNumber: $loyaltyNumber, visaDetails: $visaDetails, passportDetails: $passportDetails, carrierName: $carrierName, carrierFullName: $carrierFullName, carrierPlaneCode: $carrierPlaneCode, fromCity: $fromCity, toCity: $toCity, flightNumber: $flightNumber, fromAirport: $fromAirport, toAirport: $toAirport, fromTerminal: $fromTerminal, toTerminal: $toTerminal, segmentKey: $segmentKey, flightId: $flightId, trackId: $trackId, schDepartureTime: $schDepartureTime, schArrivalTime: $schArrivalTime, layOver: $layOver, displaySchDepartureTime: $displaySchDepartureTime, displaySchArrivalTime: $displaySchArrivalTime, travelDuration: $travelDuration, travelDurationHrs: $travelDurationHrs, layOffDuration: $layOffDuration, equipmentType: $equipmentType, otherData: $otherData, distance: $distance, unit: $unit)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlightDetailsWithPassengerPreferences &&
        other.seat == seat &&
        listEquals(other.ssrOptionsList, ssrOptionsList) &&
        other.loyaltyNumber == loyaltyNumber &&
        other.visaDetails == visaDetails &&
        other.passportDetails == passportDetails &&
        other.carrierName == carrierName &&
        other.carrierFullName == carrierFullName &&
        other.carrierPlaneCode == carrierPlaneCode &&
        other.fromCity == fromCity &&
        other.toCity == toCity &&
        other.flightNumber == flightNumber &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.fromTerminal == fromTerminal &&
        other.toTerminal == toTerminal &&
        other.segmentKey == segmentKey &&
        other.flightId == flightId &&
        other.trackId == trackId &&
        other.schDepartureTime == schDepartureTime &&
        other.schArrivalTime == schArrivalTime &&
        other.layOver == layOver &&
        other.displaySchDepartureTime == displaySchDepartureTime &&
        other.displaySchArrivalTime == displaySchArrivalTime &&
        other.travelDuration == travelDuration &&
        other.travelDurationHrs == travelDurationHrs &&
        other.layOffDuration == layOffDuration &&
        other.equipmentType == equipmentType &&
        mapEquals(other.otherData, otherData) &&
        other.distance == distance &&
        other.unit == unit;
  }

  @override
  int get hashCode {
    return seat.hashCode ^
        ssrOptionsList.hashCode ^
        loyaltyNumber.hashCode ^
        visaDetails.hashCode ^
        passportDetails.hashCode ^
        carrierName.hashCode ^
        carrierFullName.hashCode ^
        carrierPlaneCode.hashCode ^
        fromCity.hashCode ^
        toCity.hashCode ^
        flightNumber.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        fromTerminal.hashCode ^
        toTerminal.hashCode ^
        segmentKey.hashCode ^
        flightId.hashCode ^
        trackId.hashCode ^
        schDepartureTime.hashCode ^
        schArrivalTime.hashCode ^
        layOver.hashCode ^
        displaySchDepartureTime.hashCode ^
        displaySchArrivalTime.hashCode ^
        travelDuration.hashCode ^
        travelDurationHrs.hashCode ^
        layOffDuration.hashCode ^
        equipmentType.hashCode ^
        otherData.hashCode ^
        distance.hashCode ^
        unit.hashCode;
  }
}
