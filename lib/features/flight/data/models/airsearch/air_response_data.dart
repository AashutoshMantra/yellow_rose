import 'dart:convert';

import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';

class AirResponseData {
  final DateTime? schDepartureTime;
  final DateTime? schArrivalTime;
  final int? travelDuration;
  final String? source;
  final int hopCount;
  final List<FareDetailsWithType> fare;
  final List<FlightDetailsWIthBookingClass> flightDetailsList;
  final Map<String, Object>? otherData;
  final RouteRequest? routeRequest;
  AirResponseData({
    this.schDepartureTime,
    this.schArrivalTime,
    this.travelDuration,
    this.source,
    this.routeRequest,
    required this.hopCount,
    List<FareDetailsWithType>? fare,
    List<FlightDetailsWIthBookingClass>? flightDetailsList,
    this.otherData,
  })  : flightDetailsList = flightDetailsList ?? [],
        fare = fare ?? [];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result
        .addAll({'schDepartureTime': schDepartureTime?.millisecondsSinceEpoch});
    result.addAll({'schArrivalTime': schArrivalTime?.millisecondsSinceEpoch});
    if (travelDuration != null) {
      result.addAll({'travelDuration': travelDuration});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    result.addAll({'hopCount': hopCount});
    result.addAll({'fare': fare.map((x) => x.toMap()).toList()});
    result.addAll({
      'flightDetailsList': flightDetailsList.map((x) => x.toMap()).toList()
    });
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (routeRequest != null) {
      result.addAll({'routeRequest': routeRequest!.toMap()});
    }

    return result;
  }

  factory AirResponseData.fromMap(Map<String, dynamic> map) {
    return AirResponseData(
      schDepartureTime: map['schDepartureTime'] != null
          ? DateTime.tryParse(map['schDepartureTime'])
          : null,
      schArrivalTime: map['schArrivalTime'] != null
          ? DateTime.tryParse(map['schArrivalTime'])
          : null,
      travelDuration: map['travelDuration']?.toInt(),
      source: map['source'],
      hopCount: map['hopCount']?.toInt() ?? 0,
      fare: map['fare'] != null
          ? List<FareDetailsWithType>.from(
              map['fare']?.map((x) => FareDetailsWithType.fromMap(x)))
          : null,
      flightDetailsList: map['flightDetailsList'] != null
          ? List<FlightDetailsWIthBookingClass>.from(map['flightDetailsList']
              ?.map((x) => FlightDetailsWIthBookingClass.fromMap(x)))
          : null,
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      routeRequest: map['routeRequest'] != null
          ? RouteRequest.fromMap(map['routeRequest'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AirResponseData.fromJson(String source) =>
      AirResponseData.fromMap(json.decode(source));
}
