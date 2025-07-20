import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/route_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/gst_booking_detaild.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

// ignore: camel_case_types
class PNR_RetrieveResponseData {
  String? pnrNumber;
  String? providerPnrNumber;
  String? crsPNR;
  String? universalPnr;
  String? mobile;
  String? email;
  String? fop;
  String? longFreeText;
  String? officeID;
  String? agentId;
  String? bookingStatus;
  bool? paidStatus;
  bool? cancelled;
  String? fromAirport;
  String? toAirport;
  String? cartId;
  Map<String, Object>? otherData;
  RouteRequest? routeRequest;
  //  PNR_RetrieveDataElement dataElement;
  List<PassengerDetails>? passengerDetails;
  List<FlightDetailsWIthBookingClass>? pnrItineraryDetails;
  ErrorCodeHandler? errorDetails;
  GstBookingDetails? gstBookingDetails;
  //  PNR_AddMultiFOPRequest pnrAddMultiFOPRequest;
  String? requestId;
  String? sector;
  PNR_RetrieveResponseData({
    this.pnrNumber,
    this.providerPnrNumber,
    this.crsPNR,
    this.universalPnr,
    this.mobile,
    this.email,
    this.fop,
    this.longFreeText,
    this.officeID,
    this.agentId,
    this.bookingStatus,
    this.paidStatus,
    this.cancelled,
    this.fromAirport,
    this.toAirport,
    this.cartId,
    required this.otherData,
    required this.routeRequest,
    required this.passengerDetails,
    required this.pnrItineraryDetails,
    required this.errorDetails,
    required this.gstBookingDetails,
    this.requestId,
    this.sector,
  });

  PNR_RetrieveResponseData copyWith({
    String? pnrNumber,
    String? providerPnrNumber,
    String? crsPNR,
    String? universalPnr,
    String? mobile,
    String? email,
    String? fop,
    String? longFreeText,
    String? officeID,
    String? agentId,
    String? bookingStatus,
    bool? paidStatus,
    bool? cancelled,
    String? fromAirport,
    String? toAirport,
    String? cartId,
    Map<String, Object>? otherData,
    RouteRequest? routeRequest,
    List<PassengerDetails>? passengerDetails,
    List<FlightDetailsWIthBookingClass>? pnrItineraryDetails,
    ErrorCodeHandler? errorDetails,
    GstBookingDetails? gstBookingDetails,
    String? requestId,
    String? sector,
  }) {
    return PNR_RetrieveResponseData(
      pnrNumber: pnrNumber ?? this.pnrNumber,
      providerPnrNumber: providerPnrNumber ?? this.providerPnrNumber,
      crsPNR: crsPNR ?? this.crsPNR,
      universalPnr: universalPnr ?? this.universalPnr,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      fop: fop ?? this.fop,
      longFreeText: longFreeText ?? this.longFreeText,
      officeID: officeID ?? this.officeID,
      agentId: agentId ?? this.agentId,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      paidStatus: paidStatus ?? this.paidStatus,
      cancelled: cancelled ?? this.cancelled,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      cartId: cartId ?? this.cartId,
      otherData: otherData ?? this.otherData,
      routeRequest: routeRequest ?? this.routeRequest,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      pnrItineraryDetails: pnrItineraryDetails ?? this.pnrItineraryDetails,
      errorDetails: errorDetails ?? this.errorDetails,
      gstBookingDetails: gstBookingDetails ?? this.gstBookingDetails,
      requestId: requestId ?? this.requestId,
      sector: sector ?? this.sector,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (pnrNumber != null) {
      result.addAll({'pnrNumber': pnrNumber});
    }
    if (providerPnrNumber != null) {
      result.addAll({'providerPnrNumber': providerPnrNumber});
    }
    if (crsPNR != null) {
      result.addAll({'crsPNR': crsPNR});
    }
    if (universalPnr != null) {
      result.addAll({'universalPnr': universalPnr});
    }
    if (mobile != null) {
      result.addAll({'mobile': mobile});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (fop != null) {
      result.addAll({'fop': fop});
    }
    if (longFreeText != null) {
      result.addAll({'longFreeText': longFreeText});
    }
    if (officeID != null) {
      result.addAll({'officeID': officeID});
    }
    if (agentId != null) {
      result.addAll({'agentId': agentId});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus});
    }
    if (paidStatus != null) {
      result.addAll({'paidStatus': paidStatus});
    }
    if (cancelled != null) {
      result.addAll({'cancelled': cancelled});
    }
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }
    if (cartId != null) {
      result.addAll({'cartId': cartId});
    }
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (routeRequest != null) {
      result.addAll({'routeRequest': routeRequest!.toMap()});
    }
    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (pnrItineraryDetails != null) {
      result.addAll({
        'pnrItineraryDetails':
            pnrItineraryDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }
    if (gstBookingDetails != null) {
      result.addAll({'gstBookingDetails': gstBookingDetails!.toMap()});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (sector != null) {
      result.addAll({'sector': sector});
    }

    return result;
  }

  factory PNR_RetrieveResponseData.fromMap(Map<String, dynamic> map) {
    return PNR_RetrieveResponseData(
      pnrNumber: map['pnrNumber'],
      providerPnrNumber: map['providerPnrNumber'],
      crsPNR: map['crsPNR'],
      universalPnr: map['universalPnr'],
      mobile: map['mobile'],
      email: map['email'],
      fop: map['fop'],
      longFreeText: map['longFreeText'],
      officeID: map['officeID'],
      agentId: map['agentId'],
      bookingStatus: map['bookingStatus'],
      paidStatus: map['paidStatus'],
      cancelled: map['cancelled'],
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      cartId: map['cartId'],
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      routeRequest: map['routeRequest'] != null
          ? RouteRequest.fromMap(map['routeRequest'])
          : null,
      passengerDetails: map['passengerDetails'] != null
          ? List<PassengerDetails>.from(
              map['passengerDetails']?.map((x) => PassengerDetails.fromMap(x)))
          : null,
      pnrItineraryDetails: map['pnrItineraryDetails'] != null
          ? List<FlightDetailsWIthBookingClass>.from(map['pnrItineraryDetails']
              ?.map((x) => FlightDetailsWIthBookingClass.fromMap(x)))
          : null,
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
      gstBookingDetails: map['gstBookingDetails'] != null
          ? GstBookingDetails.fromMap(map['gstBookingDetails'])
          : null,
      requestId: map['requestId'],
      sector: map['sector'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PNR_RetrieveResponseData.fromJson(String source) =>
      PNR_RetrieveResponseData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PNR_RetrieveResponseData(pnrNumber: $pnrNumber, providerPnrNumber: $providerPnrNumber, crsPNR: $crsPNR, universalPnr: $universalPnr, mobile: $mobile, email: $email, fop: $fop, longFreeText: $longFreeText, officeID: $officeID, agentId: $agentId, bookingStatus: $bookingStatus, paidStatus: $paidStatus, cancelled: $cancelled, fromAirport: $fromAirport, toAirport: $toAirport, cartId: $cartId, otherData: $otherData, routeRequest: $routeRequest, passengerDetails: $passengerDetails, pnrItineraryDetails: $pnrItineraryDetails, errorDetails: $errorDetails, gstBookingDetails: $gstBookingDetails, requestId: $requestId, sector: $sector)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PNR_RetrieveResponseData &&
        other.pnrNumber == pnrNumber &&
        other.providerPnrNumber == providerPnrNumber &&
        other.crsPNR == crsPNR &&
        other.universalPnr == universalPnr &&
        other.mobile == mobile &&
        other.email == email &&
        other.fop == fop &&
        other.longFreeText == longFreeText &&
        other.officeID == officeID &&
        other.agentId == agentId &&
        other.bookingStatus == bookingStatus &&
        other.paidStatus == paidStatus &&
        other.cancelled == cancelled &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.cartId == cartId &&
        mapEquals(other.otherData, otherData) &&
        other.routeRequest == routeRequest &&
        listEquals(other.passengerDetails, passengerDetails) &&
        listEquals(other.pnrItineraryDetails, pnrItineraryDetails) &&
        other.errorDetails == errorDetails &&
        other.gstBookingDetails == gstBookingDetails &&
        other.requestId == requestId &&
        other.sector == sector;
  }

  @override
  int get hashCode {
    return pnrNumber.hashCode ^
        providerPnrNumber.hashCode ^
        crsPNR.hashCode ^
        universalPnr.hashCode ^
        mobile.hashCode ^
        email.hashCode ^
        fop.hashCode ^
        longFreeText.hashCode ^
        officeID.hashCode ^
        agentId.hashCode ^
        bookingStatus.hashCode ^
        paidStatus.hashCode ^
        cancelled.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        cartId.hashCode ^
        otherData.hashCode ^
        routeRequest.hashCode ^
        passengerDetails.hashCode ^
        pnrItineraryDetails.hashCode ^
        errorDetails.hashCode ^
        gstBookingDetails.hashCode ^
        requestId.hashCode ^
        sector.hashCode;
  }
}
