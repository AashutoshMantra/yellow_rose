import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_fare.dart';
import 'package:yellow_rose/features/bus/data/models/bus_point.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_cnacaellation_charge_rule.dart';
import 'package:yellow_rose/features/bus/data/models/search/bus_operator_detail.dart';

class BusSearchResponse {
  final String? source;
  final int? sourceId;
  final String? destination;
  final int? destinationId;
  final String? doj;
  final String? id;
  final BusOperatorDetail? operatorDetails;
  final String? busType;
  final String? route;
  final bool? aC;
  final bool? sleeper;
  final bool? seater;
  final bool? callFareBreakUpAPI;
  final DateTime? departureTime;
  final DateTime? arrivalTime;
  final String? duration;
  final int? availableSeats;
  final bool? bookable;
  final List<BusFare>? fare;
  final List<BusCancellationChargeRule>? cancellationChargeRules;
  final List<BusPoint>? boardingPoint;
  final List<BusPoint>? droppingPoint;
  BusSearchResponse({
    this.source,
    this.sourceId,
    this.destination,
    this.destinationId,
    this.doj,
    this.id,
    this.operatorDetails,
    this.busType,
    this.route,
    this.aC,
    this.sleeper,
    this.seater,
    this.callFareBreakUpAPI,
    this.departureTime,
    this.arrivalTime,
    this.duration,
    this.availableSeats,
    this.bookable,
    this.fare,
    this.cancellationChargeRules,
    this.boardingPoint,
    this.droppingPoint,
  });

  BusSearchResponse copyWith({
    String? source,
    int? sourceId,
    String? destination,
    int? destinationId,
    String? doj,
    String? id,
    BusOperatorDetail? operatorDetails,
    String? busType,
    String? route,
    bool? aC,
    bool? sleeper,
    bool? seater,
    bool? callFareBreakUpAPI,
    DateTime? departureTime,
    DateTime? arrivalTime,
    String? duration,
    int? availableSeats,
    bool? bookable,
    List<BusFare>? fare,
    List<BusCancellationChargeRule>? cancellationChargeRules,
    List<BusPoint>? boardingPoint,
    List<BusPoint>? droppingPoint,
  }) {
    return BusSearchResponse(
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      destination: destination ?? this.destination,
      destinationId: destinationId ?? this.destinationId,
      doj: doj ?? this.doj,
      id: id ?? this.id,
      operatorDetails: operatorDetails ?? this.operatorDetails,
      busType: busType ?? this.busType,
      route: route ?? this.route,
      aC: aC ?? this.aC,
      sleeper: sleeper ?? this.sleeper,
      seater: seater ?? this.seater,
      callFareBreakUpAPI: callFareBreakUpAPI ?? this.callFareBreakUpAPI,
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
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

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
    if (route != null) {
      result.addAll({'route': route});
    }
    if (aC != null) {
      result.addAll({'aC': aC});
    }
    if (sleeper != null) {
      result.addAll({'sleeper': sleeper});
    }
    if (seater != null) {
      result.addAll({'seater': seater});
    }
    if (callFareBreakUpAPI != null) {
      result.addAll({'callFareBreakUpAPI': callFareBreakUpAPI});
    }
    if (departureTime != null) {
      result.addAll({'departureTime': departureTime!.millisecondsSinceEpoch});
    }
    if (arrivalTime != null) {
      result.addAll({'arrivalTime': arrivalTime!.millisecondsSinceEpoch});
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
    if (fare != null) {
      result.addAll({'fare': fare!.map((x) => x.toMap()).toList()});
    }
    if (cancellationChargeRules != null) {
      result.addAll({
        'cancellationChargeRules':
            cancellationChargeRules!.map((x) => x.toMap()).toList()
      });
    }
    if (boardingPoint != null) {
      result.addAll(
          {'boardingPoint': boardingPoint!.map((x) => x.toMap()).toList()});
    }
    if (droppingPoint != null) {
      result.addAll(
          {'droppingPoint': droppingPoint!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory BusSearchResponse.fromMap(Map<String, dynamic> map) {
    return BusSearchResponse(
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
      route: map['route'],
      aC: map['aC'],
      sleeper: map['sleeper'],
      seater: map['seater'],
      callFareBreakUpAPI: map['callFareBreakUpAPI'],
      departureTime: map['departureTime'] != null
          ? DateTime.tryParse(map['departureTime'])
          : null,
      arrivalTime: map['arrivalTime'] != null
          ? DateTime.tryParse(map['arrivalTime'])
          : null,
      duration: map['duration'],
      availableSeats: map['availableSeats']?.toInt(),
      bookable: map['bookable'],
      fare: map['fare'] != null
          ? List<BusFare>.from(map['fare']?.map((x) => BusFare.fromMap(x)))
          : null,
      cancellationChargeRules: map['cancellationChargeRules'] != null
          ? List<BusCancellationChargeRule>.from(map['cancellationChargeRules']
              ?.map((x) => BusCancellationChargeRule.fromMap(x)))
          : null,
      boardingPoint: map['boardingPoint'] != null
          ? List<BusPoint>.from(
              map['boardingPoint']?.map((x) => BusPoint.fromMap(x)))
          : null,
      droppingPoint: map['droppingPoint'] != null
          ? List<BusPoint>.from(
              map['droppingPoint']?.map((x) => BusPoint.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusSearchResponse.fromJson(String source) =>
      BusSearchResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusSearchResponse(source: $source, sourceId: $sourceId, destination: $destination, destinationId: $destinationId, doj: $doj, id: $id, operatorDetails: $operatorDetails, busType: $busType, route: $route, aC: $aC, sleeper: $sleeper, seater: $seater, callFareBreakUpAPI: $callFareBreakUpAPI, departureTime: $departureTime, arrivalTime: $arrivalTime, duration: $duration, availableSeats: $availableSeats, bookable: $bookable, fare: $fare, cancellationChargeRules: $cancellationChargeRules, boardingPoint: $boardingPoint, droppingPoint: $droppingPoint)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusSearchResponse &&
        other.source == source &&
        other.sourceId == sourceId &&
        other.destination == destination &&
        other.destinationId == destinationId &&
        other.doj == doj &&
        other.id == id &&
        other.operatorDetails == operatorDetails &&
        other.busType == busType &&
        other.route == route &&
        other.aC == aC &&
        other.sleeper == sleeper &&
        other.seater == seater &&
        other.callFareBreakUpAPI == callFareBreakUpAPI &&
        other.departureTime == departureTime &&
        other.arrivalTime == arrivalTime &&
        other.duration == duration &&
        other.availableSeats == availableSeats &&
        other.bookable == bookable &&
        listEquals(other.fare, fare) &&
        listEquals(other.cancellationChargeRules, cancellationChargeRules) &&
        listEquals(other.boardingPoint, boardingPoint) &&
        listEquals(other.droppingPoint, droppingPoint);
  }

  @override
  int get hashCode {
    return source.hashCode ^
        sourceId.hashCode ^
        destination.hashCode ^
        destinationId.hashCode ^
        doj.hashCode ^
        id.hashCode ^
        operatorDetails.hashCode ^
        busType.hashCode ^
        route.hashCode ^
        aC.hashCode ^
        sleeper.hashCode ^
        seater.hashCode ^
        callFareBreakUpAPI.hashCode ^
        departureTime.hashCode ^
        arrivalTime.hashCode ^
        duration.hashCode ^
        availableSeats.hashCode ^
        bookable.hashCode ^
        fare.hashCode ^
        cancellationChargeRules.hashCode ^
        boardingPoint.hashCode ^
        droppingPoint.hashCode;
  }
}
