import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/domain/entities/flight_recent_search.dart';

enum RequestedClass {
  W,
  Y,
  C,
  F;

  FlightSearchClass getRequestedClass() {
    switch (this) {
      case W:
        return FlightSearchClass.PremiumEconomy;

      case Y:
        return FlightSearchClass.Economy;
      case C:
        return FlightSearchClass.BusinessClass;
      case F:
        return FlightSearchClass.FirstClass;
    }
  }
}

enum JourneyType { oneWay, Return }

class AirSearchRequest {
  List<AirSearchRequestBaseDetail>? airSearchRequestBaseDetails;
  JourneyType? journeyType;
  int? paxCount;
  int? adultCount;
  int? childCount;
  int? infantCount;
  String? requestId;
  String? travelType;
  bool? pointerEvents;
  String? countryTo;
  String? countryFrom;
  String? prefAirline;
  bool? directFlight;
  String? userBookingContext;
  String? tripUid;

  AirSearchRequest({
    this.airSearchRequestBaseDetails,
    this.journeyType,
    this.paxCount,
    this.adultCount,
    this.childCount,
    this.infantCount,
    this.requestId,
    this.travelType,
    this.pointerEvents,
    this.countryTo,
    this.countryFrom,
    this.prefAirline,
    this.directFlight,
    this.userBookingContext = "C",
    this.tripUid,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (airSearchRequestBaseDetails != null) {
      result.addAll({
        'airSearchRequestBaseDetails':
            airSearchRequestBaseDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (journeyType != null) {
      result.addAll({'journeyType': journeyType!.name});
    }
    if (paxCount != null) {
      result.addAll({'paxCount': paxCount});
    }
    if (adultCount != null) {
      result.addAll({'adultCount': adultCount});
    }
    if (childCount != null) {
      result.addAll({'childCount': childCount});
    }
    if (infantCount != null) {
      result.addAll({'infantCount': infantCount});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (travelType != null) {
      result.addAll({'travelType': travelType});
    }
    if (pointerEvents != null) {
      result.addAll({'pointerEvents': pointerEvents});
    }
    if (countryTo != null) {
      result.addAll({'countryTo': countryTo});
    }
    if (countryFrom != null) {
      result.addAll({'countryFrom': countryFrom});
    }
    if (prefAirline != null) {
      result.addAll({'prefAirline': prefAirline});
    }
    if (directFlight != null) {
      result.addAll({'directFlight': directFlight});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }

    return result;
  }

  factory AirSearchRequest.fromMap(Map<String, dynamic> map) {
    return AirSearchRequest(
      airSearchRequestBaseDetails: map['airSearchRequestBaseDetails'] != null
          ? List<AirSearchRequestBaseDetail>.from(
              map['airSearchRequestBaseDetails']
                  ?.map((x) => AirSearchRequestBaseDetail.fromMap(x)))
          : null,
      journeyType: map['journeyType'] != null
          ? (map['journeyType'] as String?)?.toEnum(JourneyType.values)
          : null,
      paxCount: map['paxCount']?.toInt(),
      adultCount: map['adultCount']?.toInt(),
      childCount: map['childCount']?.toInt(),
      infantCount: map['infantCount']?.toInt(),
      requestId: map['requestId'],
      travelType: map['travelType'],
      pointerEvents: map['pointerEvents'],
      countryTo: map['countryTo'],
      countryFrom: map['countryFrom'],
      prefAirline: map['prefAirline'],
      directFlight: map['directFlight'],
      userBookingContext: map['userBookingContext'],
      tripUid: map['tripUid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSearchRequest.fromJson(String source) =>
      AirSearchRequest.fromMap(json.decode(source));

  AirSearchRequest copyWith({
    List<AirSearchRequestBaseDetail>? airSearchRequestBaseDetails,
    JourneyType? journeyType,
    int? paxCount,
    int? adultCount,
    int? childCount,
    int? infantCount,
    String? requestId,
    String? travelType,
    bool? pointerEvents,
    String? countryTo,
    String? countryFrom,
    String? prefAirline,
    bool? directFlight,
    String? userBookingContext,
    String? tripUid,
  }) {
    return AirSearchRequest(
      airSearchRequestBaseDetails:
          airSearchRequestBaseDetails ?? this.airSearchRequestBaseDetails,
      journeyType: journeyType ?? this.journeyType,
      paxCount: paxCount ?? this.paxCount,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      infantCount: infantCount ?? this.infantCount,
      requestId: requestId ?? this.requestId,
      travelType: travelType ?? this.travelType,
      pointerEvents: pointerEvents ?? this.pointerEvents,
      countryTo: countryTo ?? this.countryTo,
      countryFrom: countryFrom ?? this.countryFrom,
      prefAirline: prefAirline ?? this.prefAirline,
      directFlight: directFlight ?? this.directFlight,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      tripUid: tripUid ?? this.tripUid,
    );
  }

  @override
  String toString() {
    return 'AirSearchRequest(airSearchRequestBaseDetails: $airSearchRequestBaseDetails, journeyType: $journeyType, paxCount: $paxCount, adultCount: $adultCount, childCount: $childCount, infantCount: $infantCount, requestId: $requestId, travelType: $travelType, pointerEvents: $pointerEvents, countryTo: $countryTo, countryFrom: $countryFrom, userBookingContext: $userBookingContext, tripUid: $tripUid)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirSearchRequest &&
        listEquals(
            other.airSearchRequestBaseDetails, airSearchRequestBaseDetails) &&
        other.journeyType == journeyType &&
        other.paxCount == paxCount &&
        other.adultCount == adultCount &&
        other.childCount == childCount &&
        other.infantCount == infantCount &&
        other.requestId == requestId &&
        other.travelType == travelType &&
        other.pointerEvents == pointerEvents &&
        other.countryTo == countryTo &&
        other.countryFrom == countryFrom &&
        other.prefAirline == prefAirline &&
        other.directFlight == directFlight &&
        other.userBookingContext == userBookingContext &&
        other.tripUid == tripUid;
  }

  @override
  int get hashCode {
    return airSearchRequestBaseDetails.hashCode ^
        journeyType.hashCode ^
        paxCount.hashCode ^
        adultCount.hashCode ^
        childCount.hashCode ^
        infantCount.hashCode ^
        requestId.hashCode ^
        travelType.hashCode ^
        pointerEvents.hashCode ^
        countryTo.hashCode ^
        countryFrom.hashCode ^
        (prefAirline?.hashCode ?? 0) ^
        (directFlight?.hashCode ?? 0) ^
        userBookingContext.hashCode ^
        (tripUid?.hashCode ?? 0);
  }
}

class AirSearchRequestBaseDetail {
  String? requestedDate;
  RequestedClass? requestedClass;
  String? fromAirport;
  String? toAirport;

  AirSearchRequestBaseDetail({
    this.requestedDate,
    this.requestedClass,
    this.fromAirport,
    this.toAirport,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (requestedDate != null) {
      result.addAll({'requestedDate': requestedDate});
    }
    if (requestedClass != null) {
      result.addAll({'requestedClass': requestedClass!.name});
    }
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }

    return result;
  }

  factory AirSearchRequestBaseDetail.fromMap(Map<String, dynamic> map) {
    return AirSearchRequestBaseDetail(
      requestedDate: (map['requestedDate'] is String?)
          ? map['requestedDate']
          : DateTime.fromMillisecondsSinceEpoch(map['requestedDate'])
              .toString(),
      requestedClass:
          (map['requestedClass'] as String?)?.toEnum(RequestedClass.values),
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSearchRequestBaseDetail.fromJson(String source) =>
      AirSearchRequestBaseDetail.fromMap(json.decode(source));

  AirSearchRequestBaseDetail copyWith({
    String? requestedDate,
    RequestedClass? requestedClass,
    String? fromAirport,
    String? toAirport,
  }) {
    return AirSearchRequestBaseDetail(
      requestedDate: requestedDate ?? this.requestedDate,
      requestedClass: requestedClass ?? this.requestedClass,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
    );
  }

  @override
  String toString() {
    return 'AirSearchRequestBaseDetail(requestedDate: $requestedDate, requestedClass: $requestedClass, fromAirport: $fromAirport, toAirport: $toAirport)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirSearchRequestBaseDetail &&
        other.requestedDate == requestedDate &&
        other.requestedClass == requestedClass &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport;
  }

  @override
  int get hashCode {
    return requestedDate.hashCode ^
        requestedClass.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode;
  }
}
