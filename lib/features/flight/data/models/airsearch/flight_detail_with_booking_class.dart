import 'dart:convert';

import 'package:yellow_rose/core/utils/date_time_parser.dart';
import 'package:yellow_rose/features/flight/data/models/booking_class.dart';

class FlightDetailsWIthBookingClass {
  final List<BookingClass> bookingClasses;
  final String carrierName;
  final String flightNumber;
  final String fromAirport;
  final String toAirport;
  final String? fromTerminal;
  final String? toTerminal;
  final DateTime schDepartureTime;
  final DateTime schArrivalTime;
  final int travelDuration;
  final Map<String, Object>? otherData;
  final String? equipmentType;
  final String? distance;
  final String? segmentKey;
  FlightDetailsWIthBookingClass({
    List<BookingClass>? bookingClasses,
    required this.carrierName,
    required this.flightNumber,
    required this.fromAirport,
    required this.toAirport,
    this.fromTerminal,
    this.toTerminal,
    required this.schDepartureTime,
    required this.schArrivalTime,
    required this.travelDuration,
    this.otherData,
    this.equipmentType,
    this.distance,
    this.segmentKey,
  }) : bookingClasses = bookingClasses ?? [];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll(
        {'bookingClasses': bookingClasses.map((x) => x.toMap()).toList()});
    result.addAll({'carrierName': carrierName});
    result.addAll({'flightNumber': flightNumber});
    result.addAll({'fromAirport': fromAirport});
    result.addAll({'toAirport': toAirport});
    result.addAll({'fromTerminal': fromTerminal});
    result.addAll({'toTerminal': toTerminal});
    result
        .addAll({'schDepartureTime': schDepartureTime.millisecondsSinceEpoch});
    result.addAll({'schArrivalTime': schArrivalTime.millisecondsSinceEpoch});
    result.addAll({'travelDuration': travelDuration});
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (equipmentType != null) {
      result.addAll({'equipmentType': equipmentType});
    }
    if (distance != null) {
      result.addAll({'distance': distance});
    }
    if (segmentKey != null) {
      result.addAll({'segmentKey': segmentKey});
    }

    return result;
  }

  factory FlightDetailsWIthBookingClass.fromMap(Map<String, dynamic> map) {
    return FlightDetailsWIthBookingClass(
      bookingClasses: List<BookingClass>.from(
          map['bookingClasses']?.map((x) => BookingClass.fromMap(x))),
      carrierName: map['carrierName'] ?? '',
      flightNumber: map['flightNumber'] ?? '',
      fromAirport: map['fromAirport'] ?? '',
      toAirport: map['toAirport'] ?? '',
      fromTerminal: map['fromTerminal']?.toString(),
      toTerminal: map['toTerminal']?.toString(),
      schDepartureTime: DateTimeParser.parseFromMap(map, 'schDepartureTime')!,
      schArrivalTime: DateTimeParser.parseFromMap(map, 'schArrivalTime')!,
      travelDuration: map['travelDuration']?.toInt() ?? 0,
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      equipmentType: map['equipmentType'],
      distance: map['distance'],
      segmentKey: map['segmentKey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlightDetailsWIthBookingClass.fromJson(String source) =>
      FlightDetailsWIthBookingClass.fromMap(json.decode(source));

  FlightDetailsWIthBookingClass copyWith({
    List<BookingClass>? bookingClasses,
    String? carrierName,
    String? flightNumber,
    String? fromAirport,
    String? toAirport,
    String? fromTerminal,
    String? toTerminal,
    DateTime? schDepartureTime,
    DateTime? schArrivalTime,
    int? travelDuration,
    Map<String, Object>? otherData,
    String? equipmentType,
    String? distance,
    String? segmentKey,
  }) {
    return FlightDetailsWIthBookingClass(
      bookingClasses: bookingClasses ?? this.bookingClasses,
      carrierName: carrierName ?? this.carrierName,
      flightNumber: flightNumber ?? this.flightNumber,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      fromTerminal: fromTerminal ?? this.fromTerminal,
      toTerminal: toTerminal ?? this.toTerminal,
      schDepartureTime: schDepartureTime ?? this.schDepartureTime,
      schArrivalTime: schArrivalTime ?? this.schArrivalTime,
      travelDuration: travelDuration ?? this.travelDuration,
      otherData: otherData ?? this.otherData,
      equipmentType: equipmentType ?? this.equipmentType,
      distance: distance ?? this.distance,
      segmentKey: segmentKey ?? this.segmentKey,
    );
  }
}
