import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/advance_pricign_segment.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/fare_details_with_type.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/group_search_itinaries.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/form_or_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';
import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class UserBookingRequest {
  final List<OrdersPassengersDetails>? passengerDetails;
  final List<GroupedSearchItineraries>? itineraries;
  final AdvancedPricingSegment? advancedPricingData;
  final Map<String, Object>? commissionData;
  final List<FareDetailsWithType>? fare;
  final DateTime? schArrivalTime;
  final DateTime? schDepartureTime;
  final String? displaySchDepartureTime;
  final String? displaySchArrivalTime;

  final int hopeCount;
  final String? travelDuration;
  final String? contactNumber;
  final String? email;
  final String? gstNumber;

  final String fromAirport;
  final String toAirport;
  final String? source;
  final RouteRequest? routeRequest;

  final List<FlightDetailsWIthBookingClass> flightDetailsList;
  final Map<String, Object>? otherData;

  final FormOfPayment? formOfPayment;
  bool holdBooking = true;
  UserBookingRequest({
    this.passengerDetails,
    this.itineraries,
    this.advancedPricingData,
    this.commissionData,
    this.fare,
    this.schArrivalTime,
    this.schDepartureTime,
    this.displaySchDepartureTime,
    this.displaySchArrivalTime,
    required this.hopeCount,
    this.travelDuration,
    this.contactNumber,
    this.email,
    this.gstNumber,
    required this.fromAirport,
    required this.toAirport,
    this.source,
    this.routeRequest,
    required this.flightDetailsList,
    this.otherData,
    this.formOfPayment,
    required this.holdBooking,
  });

  UserBookingRequest copyWith({
    List<OrdersPassengersDetails>? passengerDetails,
    List<GroupedSearchItineraries>? itineraries,
    AdvancedPricingSegment? advancedPricingData,
    Map<String, Object>? commissionData,
    List<FareDetailsWithType>? fare,
    DateTime? schArrivalTime,
    DateTime? schDepartureTime,
    String? displaySchDepartureTime,
    String? displaySchArrivalTime,
    int? hopeCount,
    String? travelDuration,
    String? contactNumber,
    String? email,
    String? gstNumber,
    String? fromAirport,
    String? toAirport,
    String? source,
    RouteRequest? routeRequest,
    List<FlightDetailsWIthBookingClass>? flightDetailsList,
    Map<String, Object>? otherData,
    FormOfPayment? formOfPayment,
    bool? holdBooking,
  }) {
    return UserBookingRequest(
      passengerDetails: passengerDetails ?? this.passengerDetails,
      itineraries: itineraries ?? this.itineraries,
      advancedPricingData: advancedPricingData ?? this.advancedPricingData,
      commissionData: commissionData ?? this.commissionData,
      fare: fare ?? this.fare,
      schArrivalTime: schArrivalTime ?? this.schArrivalTime,
      schDepartureTime: schDepartureTime ?? this.schDepartureTime,
      displaySchDepartureTime:
          displaySchDepartureTime ?? this.displaySchDepartureTime,
      displaySchArrivalTime:
          displaySchArrivalTime ?? this.displaySchArrivalTime,
      hopeCount: hopeCount ?? this.hopeCount,
      travelDuration: travelDuration ?? this.travelDuration,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstNumber: gstNumber ?? this.gstNumber,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      source: source ?? this.source,
      routeRequest: routeRequest ?? this.routeRequest,
      flightDetailsList: flightDetailsList ?? this.flightDetailsList,
      otherData: otherData ?? this.otherData,
      formOfPayment: formOfPayment ?? this.formOfPayment,
      holdBooking: holdBooking ?? this.holdBooking,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (itineraries != null) {
      result
          .addAll({'itineraries': itineraries!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'advancedPricingData': advancedPricingData?.toMap()});
    if (commissionData != null) {
      result.addAll({'commissionData': commissionData});
    }
    if (fare != null) {
      result.addAll({'fare': fare!.map((x) => x.toMap()).toList()});
    }
    if (schArrivalTime != null) {
      result.addAll({'schArrivalTime': schArrivalTime!.millisecondsSinceEpoch});
    }
    if (schDepartureTime != null) {
      result.addAll(
          {'schDepartureTime': schDepartureTime!.millisecondsSinceEpoch});
    }
    if (displaySchDepartureTime != null) {
      result.addAll({'displaySchDepartureTime': displaySchDepartureTime});
    }
    if (displaySchArrivalTime != null) {
      result.addAll({'displaySchArrivalTime': displaySchArrivalTime});
    }
    result.addAll({'hopeCount': hopeCount});
    if (travelDuration != null) {
      result.addAll({'travelDuration': travelDuration});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (gstNumber != null) {
      result.addAll({'gstNumber': gstNumber});
    }
    result.addAll({'fromAirport': fromAirport});
    result.addAll({'toAirport': toAirport});
    if (source != null) {
      result.addAll({'source': source!});
    }
    if (routeRequest != null) {
      result.addAll({'routeRequest': routeRequest!.toMap()});
    }
    result.addAll({
      'flightDetailsList': flightDetailsList.map((x) => x.toMap()).toList()
    });
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (formOfPayment != null) {
      result.addAll({'formOfPayment': formOfPayment!.toMap()});
    }
    result.addAll({'holdBooking': holdBooking});

    return result;
  }

  factory UserBookingRequest.fromMap(Map<String, dynamic> map) {
    return UserBookingRequest(
      passengerDetails: map['passengerDetails'] != null
          ? List<OrdersPassengersDetails>.from(map['passengerDetails']
              ?.map((x) => OrdersPassengersDetails.fromMap(x)))
          : null,
      itineraries: map['itineraries'] != null
          ? List<GroupedSearchItineraries>.from(map['itineraries']
              ?.map((x) => GroupedSearchItineraries.fromMap(x)))
          : null,
      advancedPricingData:
          AdvancedPricingSegment.fromMap(map['advancedPricingData']),
      commissionData: map['commissionData'] != null
          ? Map<String, Object>.from(map['commissionData'])
          : null,
      fare: map['fare'] != null
          ? List<FareDetailsWithType>.from(
              map['fare']?.map((x) => FareDetailsWithType.fromMap(x)))
          : null,
      schArrivalTime: map['schArrivalTime'] != null
          ? DateTime.tryParse(map['schArrivalTime'])
          : null,
      schDepartureTime: map['schDepartureTime'] != null
          ? DateTime.tryParse(map['schDepartureTime'])
          : null,
      displaySchDepartureTime: map['displaySchDepartureTime'],
      displaySchArrivalTime: map['displaySchArrivalTime'],
      hopeCount: map['hopeCount']?.toInt() ?? 0,
      travelDuration: map['travelDuration'],
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstNumber: map['gstNumber'],
      fromAirport: map['fromAirport'] ?? '',
      toAirport: map['toAirport'] ?? '',
      source: map['source'],
      routeRequest: map['routeRequest'] != null
          ? RouteRequest.fromMap(map['routeRequest'])
          : null,
      flightDetailsList: List<FlightDetailsWIthBookingClass>.from(
          map['flightDetailsList']
              ?.map((x) => FlightDetailsWIthBookingClass.fromMap(x))),
      otherData: map['commissionData'] != null
          ? Map<String, Object>.from(map['commissionData'])
          : null,
      formOfPayment: map['formOfPayment'] != null
          ? FormOfPayment.fromMap(map['formOfPayment'])
          : null,
      holdBooking: map['holdBooking'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserBookingRequest.fromJson(String source) =>
      UserBookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserBookingRequest(passengerDetails: $passengerDetails, itineraries: $itineraries, advancedPricingData: $advancedPricingData, commissionData: $commissionData, fare: $fare, schArrivalTime: $schArrivalTime, schDepartureTime: $schDepartureTime, displaySchDepartureTime: $displaySchDepartureTime, displaySchArrivalTime: $displaySchArrivalTime, hopeCount: $hopeCount, travelDuration: $travelDuration, contactNumber: $contactNumber, email: $email, gstNumber: $gstNumber, fromAirport: $fromAirport, toAirport: $toAirport, source: $source, routeRequest: $routeRequest, flightDetailsList: $flightDetailsList, otherData: $otherData, formOfPayment: $formOfPayment, holdBooking: $holdBooking)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserBookingRequest &&
        listEquals(other.passengerDetails, passengerDetails) &&
        listEquals(other.itineraries, itineraries) &&
        other.advancedPricingData == advancedPricingData &&
        mapEquals(other.commissionData, commissionData) &&
        listEquals(other.fare, fare) &&
        other.schArrivalTime == schArrivalTime &&
        other.schDepartureTime == schDepartureTime &&
        other.displaySchDepartureTime == displaySchDepartureTime &&
        other.displaySchArrivalTime == displaySchArrivalTime &&
        other.hopeCount == hopeCount &&
        other.travelDuration == travelDuration &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstNumber == gstNumber &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.source == source &&
        other.routeRequest == routeRequest &&
        listEquals(other.flightDetailsList, flightDetailsList) &&
        mapEquals(other.otherData, otherData) &&
        other.formOfPayment == formOfPayment &&
        other.holdBooking == holdBooking;
  }

  @override
  int get hashCode {
    return passengerDetails.hashCode ^
        itineraries.hashCode ^
        advancedPricingData.hashCode ^
        commissionData.hashCode ^
        fare.hashCode ^
        schArrivalTime.hashCode ^
        schDepartureTime.hashCode ^
        displaySchDepartureTime.hashCode ^
        displaySchArrivalTime.hashCode ^
        hopeCount.hashCode ^
        travelDuration.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstNumber.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        source.hashCode ^
        routeRequest.hashCode ^
        flightDetailsList.hashCode ^
        otherData.hashCode ^
        formOfPayment.hashCode ^
        holdBooking.hashCode;
  }
}
