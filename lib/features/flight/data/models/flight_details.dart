import 'dart:convert';

import 'package:yellow_rose/core/utils/date_time_parser.dart';

class FlightDetails {
  final String carrierName;
  final String flightNumber;
  final String fromAirport;
  final String toAirport;
  final String fromTerminal;
  final String toTerminal;
  final DateTime schDepartureTime;
  final DateTime schArrivalTime;
  final int travelDuration;
  final Map<String, Object>? otherData;
  final String? equipmentType;
  final String? distance;
  final String? segmentKey;
  FlightDetails({
    required this.carrierName,
    required this.flightNumber,
    required this.fromAirport,
    required this.toAirport,
    required this.fromTerminal,
    required this.toTerminal,
    required this.schDepartureTime,
    required this.schArrivalTime,
    required this.travelDuration,
    this.otherData,
    this.equipmentType,
    this.distance,
    this.segmentKey,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

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

  factory FlightDetails.fromMap(Map<String, dynamic> map) {
    return FlightDetails(
      carrierName: map['carrierName'] ?? '',
      flightNumber: map['flightNumber'] ?? '',
      fromAirport: map['fromAirport'] ?? '',
      toAirport: map['toAirport'] ?? '',
      fromTerminal: map['fromTerminal'] ?? '',
      toTerminal: map['toTerminal'] ?? '',
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

  factory FlightDetails.fromJson(String source) =>
      FlightDetails.fromMap(json.decode(source));
}
