import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/form_or_payment.dart';
import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class AirLatestFlightDetailsSearch {
  final List<FlightDetailsWIthBookingClass>? flightDetailsList;
  final Map<String, Object>? otherData;
  final RouteRequest? routeRequest;
  final FormOfPayment? formOfPayment;
  bool holdBooking = true;

  final String? fromAirport;
  final String? toAirport;
  final String? source;
  AirLatestFlightDetailsSearch({
    this.flightDetailsList,
    this.otherData,
    this.routeRequest,
    this.formOfPayment,
    required this.holdBooking,
    this.fromAirport,
    this.toAirport,
    this.source,
  });

  AirLatestFlightDetailsSearch copyWith({
    List<FlightDetailsWIthBookingClass>? flightDetailsList,
    Map<String, Object>? otherData,
    RouteRequest? routeRequest,
    FormOfPayment? formOfPayment,
    bool? holdBooking,
    String? fromAirport,
    String? toAirport,
    String? source,
  }) {
    return AirLatestFlightDetailsSearch(
      flightDetailsList: flightDetailsList ?? this.flightDetailsList,
      otherData: otherData ?? this.otherData,
      routeRequest: routeRequest ?? this.routeRequest,
      formOfPayment: formOfPayment ?? this.formOfPayment,
      holdBooking: holdBooking ?? this.holdBooking,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      source: source ?? this.source,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (flightDetailsList != null) {
      result.addAll({
        'flightDetailsList': flightDetailsList!.map((x) => x.toMap()).toList()
      });
    }
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (routeRequest != null) {
      result.addAll({'routeRequest': routeRequest!.toMap()});
    }
    if (formOfPayment != null) {
      result.addAll({'formOfPayment': formOfPayment!.toMap()});
    }
    result.addAll({'holdBooking': holdBooking});
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }
    if (source != null) {
      result.addAll({'source': source});
    }

    return result;
  }

  factory AirLatestFlightDetailsSearch.fromMap(Map<String, dynamic> map) {
    return AirLatestFlightDetailsSearch(
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
      formOfPayment: map['formOfPayment'] != null
          ? FormOfPayment.fromMap(map['formOfPayment'])
          : null,
      holdBooking: map['holdBooking'] ?? false,
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      source: map['source'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirLatestFlightDetailsSearch.fromJson(String source) =>
      AirLatestFlightDetailsSearch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AirLatestFlightDetailsSearch(flightDetailsList: $flightDetailsList, otherData: $otherData, routeRequest: $routeRequest, formOfPayment: $formOfPayment, holdBooking: $holdBooking, fromAirport: $fromAirport, toAirport: $toAirport, source: $source)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirLatestFlightDetailsSearch &&
        listEquals(other.flightDetailsList, flightDetailsList) &&
        mapEquals(other.otherData, otherData) &&
        other.routeRequest == routeRequest &&
        other.formOfPayment == formOfPayment &&
        other.holdBooking == holdBooking &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.source == source;
  }

  @override
  int get hashCode {
    return flightDetailsList.hashCode ^
        otherData.hashCode ^
        routeRequest.hashCode ^
        formOfPayment.hashCode ^
        holdBooking.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        source.hashCode;
  }
}
