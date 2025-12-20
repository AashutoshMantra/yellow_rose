import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'package:yellow_rose/features/bus/data/models/bus_fare.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/order/bus_cancelaltion_rule.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_operator_detail.dart';

class UserBusBookingRequest {
  final String? requestId; // request tracking
  final String? source; // e.g. Hyderabad
  final int? sourceId; // e.g. 6
  final String? destination; // e.g. Bangalore
  final int? destinationId; // e.g. 3
  final String? doj; // Date of journey
  final String? id; // bus trip id / schedule id
  final BusOperatorDetail? operatorDetails; // nested object
  final String? busType;
  final bool? sleeper;
  final bool? seater;
  final String? departureTime;
  final String? arrivalTime;
  final String? duration;
  final int? availableSeats;
  final bool? bookable;
  final List<BusFare> fare;
  final List<BusCancelaltionRule> cancellationChargeRules;
  final List<BusPoint>? boardingPoint;
  final List<BusPoint>? droppingPoint;
  final List<BusSeats> seats;
  final bool? ac;
  final Map<String, Object>? otherData;
  UserBusBookingRequest({
    this.requestId,
    this.source,
    this.sourceId,
    this.destination,
    this.destinationId,
    this.doj,
    this.id,
    this.operatorDetails,
    this.busType,
    this.sleeper,
    this.seater,
    this.departureTime,
    this.arrivalTime,
    this.duration,
    this.availableSeats,
    this.bookable,
    required this.fare,
    required this.cancellationChargeRules,
    this.boardingPoint,
    this.droppingPoint,
    required this.seats,
    this.ac,
    this.otherData,
  });
  final bool? holdBooking = true;

  UserBusBookingRequest copyWith({
    String? requestId,
    String? source,
    int? sourceId,
    String? destination,
    int? destinationId,
    String? doj,
    String? id,
    BusOperatorDetail? operatorDetails,
    String? busType,
    bool? sleeper,
    bool? seater,
    String? departureTime,
    String? arrivalTime,
    String? duration,
    int? availableSeats,
    bool? bookable,
    List<BusFare>? fare,
    List<BusCancelaltionRule>? cancellationChargeRules,
    List<BusPoint>? boardingPoint,
    List<BusPoint>? droppingPoint,
    List<BusSeats>? seats,
    bool? ac,
    Map<String, Object>? otherData,
  }) {
    return UserBusBookingRequest(
      requestId: requestId ?? this.requestId,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      destination: destination ?? this.destination,
      destinationId: destinationId ?? this.destinationId,
      doj: doj ?? this.doj,
      id: id ?? this.id,
      operatorDetails: operatorDetails ?? this.operatorDetails,
      busType: busType ?? this.busType,
      sleeper: sleeper ?? this.sleeper,
      seater: seater ?? this.seater,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      duration: duration ?? this.duration,
      availableSeats: availableSeats ?? this.availableSeats,
      bookable: bookable ?? this.bookable,
      fare: fare ?? this.fare,
      cancellationChargeRules:
          cancellationChargeRules ?? this.cancellationChargeRules,
      boardingPoint: boardingPoint ?? this.boardingPoint,
      droppingPoint: droppingPoint ?? this.droppingPoint,
      seats: seats ?? this.seats,
      ac: ac ?? this.ac,
      otherData: otherData ?? this.otherData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (sourceId != null) {
      result.addAll({'sourceId': sourceId});
    }
    if (destination != null) {
      result.addAll({'destination': destination});
    }
    if (destinationId != null) {
      result.addAll({'destinationId': destinationId});
    }
    if (doj != null) {
      result.addAll({'doj': doj});
    }
    if (id != null) {
      result.addAll({'id': id});
    }
    if (operatorDetails != null) {
      result.addAll({'operatorDetails': operatorDetails!.toMap()});
    }
    if (busType != null) {
      result.addAll({'busType': busType});
    }
    if (sleeper != null) {
      result.addAll({'sleeper': sleeper});
    }
    if (seater != null) {
      result.addAll({'seater': seater});
    }
    if (departureTime != null) {
      result.addAll({'departureTime': departureTime});
    }
    if (arrivalTime != null) {
      result.addAll({'arrivalTime': arrivalTime});
    }
    if (duration != null) {
      result.addAll({'duration': duration});
    }
    if (availableSeats != null) {
      result.addAll({'availableSeats': availableSeats});
    }
    if (bookable != null) {
      result.addAll({'bookable': bookable});
    }
    result.addAll({'fare': fare.map((x) => x.toMap()).toList()});
    result.addAll({
      'cancellationChargeRules':
          cancellationChargeRules.map((x) => x.toMap()).toList()
    });
    if (boardingPoint != null) {
      result.addAll(
          {'boardingPoint': boardingPoint!.map((x) => x.toMap()).toList()});
    }
    if (droppingPoint != null) {
      result.addAll(
          {'droppingPoint': droppingPoint!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'seats': seats.map((x) => x.toMap()).toList()});
    if (ac != null) {
      result.addAll({'ac': ac});
    }
    result.addAll({'otherData': otherData});

    return result;
  }

  factory UserBusBookingRequest.fromMap(Map<String, dynamic> map) {
    return UserBusBookingRequest(
      requestId: map['requestId'],
      source: map['source'],
      sourceId: map['sourceId']?.toInt(),
      destination: map['destination'],
      destinationId: map['destinationId']?.toInt(),
      doj: map['doj'],
      id: map['id'],
      operatorDetails: map['operatorDetails'] != null
          ? BusOperatorDetail.fromMap(map['operatorDetails'])
          : null,
      busType: map['busType'],
      sleeper: map['sleeper'],
      seater: map['seater'],
      departureTime: map['departureTime'],
      arrivalTime: map['arrivalTime'],
      duration: map['duration'],
      availableSeats: map['availableSeats']?.toInt(),
      bookable: map['bookable'],
      fare: List<BusFare>.from(map['fare']?.map((x) => BusFare.fromMap(x))),
      cancellationChargeRules: List<BusCancelaltionRule>.from(
          map['cancellationChargeRules']
              ?.map((x) => BusCancelaltionRule.fromMap(x))),
      boardingPoint: map['boardingPoint'] != null
          ? List<BusPoint>.from(
              map['boardingPoint']?.map((x) => BusPoint.fromMap(x)))
          : null,
      droppingPoint: map['droppingPoint'] != null
          ? List<BusPoint>.from(
              map['droppingPoint']?.map((x) => BusPoint.fromMap(x)))
          : null,
      seats: List<BusSeats>.from(map['seats']?.map((x) => BusSeats.fromMap(x))),
      ac: map['ac'],
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBusBookingRequest.fromJson(String source) =>
      UserBusBookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBusBookingRequest(requestId: $requestId, source: $source, sourceId: $sourceId, destination: $destination, destinationId: $destinationId, doj: $doj, id: $id, operatorDetails: $operatorDetails, busType: $busType, sleeper: $sleeper, seater: $seater, departureTime: $departureTime, arrivalTime: $arrivalTime, duration: $duration, availableSeats: $availableSeats, bookable: $bookable, fare: $fare, cancellationChargeRules: $cancellationChargeRules, boardingPoint: $boardingPoint, droppingPoint: $droppingPoint, seats: $seats, ac: $ac, otherData: $otherData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBusBookingRequest &&
        other.requestId == requestId &&
        other.source == source &&
        other.sourceId == sourceId &&
        other.destination == destination &&
        other.destinationId == destinationId &&
        other.doj == doj &&
        other.id == id &&
        other.operatorDetails == operatorDetails &&
        other.busType == busType &&
        other.sleeper == sleeper &&
        other.seater == seater &&
        other.departureTime == departureTime &&
        other.arrivalTime == arrivalTime &&
        other.duration == duration &&
        other.availableSeats == availableSeats &&
        other.bookable == bookable &&
        listEquals(other.fare, fare) &&
        listEquals(other.cancellationChargeRules, cancellationChargeRules) &&
        listEquals(other.boardingPoint, boardingPoint) &&
        listEquals(other.droppingPoint, droppingPoint) &&
        listEquals(other.seats, seats) &&
        other.ac == ac &&
        mapEquals(other.otherData, otherData);
  }

  @override
  int get hashCode {
    return requestId.hashCode ^
        source.hashCode ^
        sourceId.hashCode ^
        destination.hashCode ^
        destinationId.hashCode ^
        doj.hashCode ^
        id.hashCode ^
        operatorDetails.hashCode ^
        busType.hashCode ^
        sleeper.hashCode ^
        seater.hashCode ^
        departureTime.hashCode ^
        arrivalTime.hashCode ^
        duration.hashCode ^
        availableSeats.hashCode ^
        bookable.hashCode ^
        fare.hashCode ^
        cancellationChargeRules.hashCode ^
        boardingPoint.hashCode ^
        droppingPoint.hashCode ^
        seats.hashCode ^
        ac.hashCode ^
        otherData.hashCode;
  }
}
