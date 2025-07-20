import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/advance_pricign_segment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/form_or_payment.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/gst_booking_detaild.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/booking/reprice/air_latest_price_detail-search.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class BookingRequest {
  final FormOfPayment? formOfPayment;
  final String? contactNumber;
  final String? email;
  final String? gstEmail;
  final String? gstNumber;
  final String? billingEntity;
  final GstBookingDetails? gstBookingDetails;
  final List<AdvancedPricingSegment>? runtimeMarkUp;
  final ErrorCodeHandler? errorDetails;

  bool isInternational = false;
  bool isDomestic = false;
  final int paxCount;
  final int adultCount;
  final int childCount;
  final int infantCount;
  final String? requestId;
  final String? userBookingContext;
  final String? prefAirline;
  final String? travelType;
  final String? journeyType;
  final bool? directFlight;
  final String? prefAirSource;
  final String? dealCode;

  final List<AirLatestFlightDetailsSearch>? selectedFlight;
  final Map<String, Object>? otherData;
  final List<PassengerDetails>? passengerDetails;
  final String? segmentRefFrom;
  final String? segmentRefTo;
  final String? cartId;
  bool hold = false;
  BookingRequest({
    this.formOfPayment,
    this.contactNumber,
    this.email,
    this.gstEmail,
    this.gstNumber,
    this.billingEntity,
    this.gstBookingDetails,
    this.runtimeMarkUp,
    this.errorDetails,
    this.isInternational = false,
    this.isDomestic = true,
    required this.paxCount,
    required this.adultCount,
    required this.childCount,
    required this.infantCount,
    this.requestId,
    this.userBookingContext,
    this.prefAirline,
    this.travelType,
    this.journeyType,
    this.directFlight,
    this.prefAirSource,
    this.dealCode,
    this.selectedFlight,
    this.otherData,
    this.passengerDetails,
    this.segmentRefFrom,
    this.segmentRefTo,
    this.cartId,
    this.hold = true,
  });

  BookingRequest copyWith({
    FormOfPayment? formOfPayment,
    String? contactNumber,
    String? email,
    String? gstEmail,
    String? gstNumber,
    String? billingEntity,
    GstBookingDetails? gstBookingDetails,
    List<AdvancedPricingSegment>? runtimeMarkUp,
    ErrorCodeHandler? errorDetails,
    bool? isInternational,
    bool? isDomestic,
    int? paxCount,
    int? adultCount,
    int? childCount,
    int? infantCount,
    String? requestId,
    String? userBookingContext,
    String? prefAirline,
    String? travelType,
    String? journeyType,
    bool? directFlight,
    String? prefAirSource,
    String? dealCode,
    List<AirLatestFlightDetailsSearch>? selectedFlight,
    Map<String, Object>? otherData,
    List<PassengerDetails>? passengerDetails,
    String? segmentRefFrom,
    String? segmentRefTo,
    String? cartId,
    bool? hold,
  }) {
    return BookingRequest(
      formOfPayment: formOfPayment ?? this.formOfPayment,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstEmail: gstEmail ?? this.gstEmail,
      gstNumber: gstNumber ?? this.gstNumber,
      billingEntity: billingEntity ?? this.billingEntity,
      gstBookingDetails: gstBookingDetails ?? this.gstBookingDetails,
      runtimeMarkUp: runtimeMarkUp ?? this.runtimeMarkUp,
      errorDetails: errorDetails ?? this.errorDetails,
      isInternational: isInternational ?? this.isInternational,
      isDomestic: isDomestic ?? this.isDomestic,
      paxCount: paxCount ?? this.paxCount,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      infantCount: infantCount ?? this.infantCount,
      requestId: requestId ?? this.requestId,
      userBookingContext: userBookingContext ?? this.userBookingContext,
      prefAirline: prefAirline ?? this.prefAirline,
      travelType: travelType ?? this.travelType,
      journeyType: journeyType ?? this.journeyType,
      directFlight: directFlight ?? this.directFlight,
      prefAirSource: prefAirSource ?? this.prefAirSource,
      dealCode: dealCode ?? this.dealCode,
      selectedFlight: selectedFlight ?? this.selectedFlight,
      otherData: otherData ?? this.otherData,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      segmentRefFrom: segmentRefFrom ?? this.segmentRefFrom,
      segmentRefTo: segmentRefTo ?? this.segmentRefTo,
      cartId: cartId ?? this.cartId,
      hold: hold ?? this.hold,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (formOfPayment != null) {
      result.addAll({'formOfPayment': formOfPayment!.toMap()});
    }
    if (contactNumber != null) {
      result.addAll({'contactNumber': contactNumber});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (gstEmail != null) {
      result.addAll({'gstEmail': gstEmail});
    }
    if (gstNumber != null) {
      result.addAll({'gstNumber': gstNumber});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (gstBookingDetails != null) {
      result.addAll({'gstBookingDetails': gstBookingDetails!.toMap()});
    }
    if (runtimeMarkUp != null) {
      result.addAll(
          {'runtimeMarkUp': runtimeMarkUp!.map((x) => x.toMap()).toList()});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }
    result.addAll({'isInternational': isInternational});
    result.addAll({'isDomestic': isDomestic});
    result.addAll({'paxCount': paxCount});
    result.addAll({'adultCount': adultCount});
    result.addAll({'childCount': childCount});
    result.addAll({'infantCount': infantCount});
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }
    if (prefAirline != null) {
      result.addAll({'prefAirline': prefAirline});
    }
    if (travelType != null) {
      result.addAll({'travelType': travelType});
    }
    if (journeyType != null) {
      result.addAll({'journeyType': journeyType});
    }
    if (directFlight != null) {
      result.addAll({'directFlight': directFlight});
    }
    if (prefAirSource != null) {
      result.addAll({'prefAirSource': prefAirSource});
    }
    if (dealCode != null) {
      result.addAll({'dealCode': dealCode});
    }
    if (selectedFlight != null) {
      result.addAll(
          {'selectedFlight': selectedFlight!.map((x) => x.toMap()).toList()});
    }
    if (otherData != null) {
      result.addAll({'otherData': otherData});
    }
    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (segmentRefFrom != null) {
      result.addAll({'segmentRefFrom': segmentRefFrom});
    }
    if (segmentRefTo != null) {
      result.addAll({'segmentRefTo': segmentRefTo});
    }
    if (cartId != null) {
      result.addAll({'cartId': cartId});
    }
    result.addAll({'hold': hold});

    return result;
  }

  factory BookingRequest.fromMap(Map<String, dynamic> map) {
    return BookingRequest(
      formOfPayment: map['formOfPayment'] != null
          ? FormOfPayment.fromMap(map['formOfPayment'])
          : null,
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstEmail: map['gstEmail'],
      gstNumber: map['gstNumber'],
      billingEntity: map['billingEntity'],
      gstBookingDetails: map['gstBookingDetails'] != null
          ? GstBookingDetails.fromMap(map['gstBookingDetails'])
          : null,
      runtimeMarkUp: map['runtimeMarkUp'] != null
          ? List<AdvancedPricingSegment>.from(map['runtimeMarkUp']
              ?.map((x) => AdvancedPricingSegment.fromMap(x)))
          : null,
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
      isInternational: map['isInternational'] ?? false,
      isDomestic: map['isDomestic'] ?? false,
      paxCount: map['paxCount']?.toInt() ?? 0,
      adultCount: map['adultCount']?.toInt() ?? 0,
      childCount: map['childCount']?.toInt() ?? 0,
      infantCount: map['infantCount']?.toInt() ?? 0,
      requestId: map['requestId'],
      userBookingContext: map['userBookingContext'],
      prefAirline: map['prefAirline'],
      travelType: map['travelType'],
      journeyType: map['journeyType'],
      directFlight: map['directFlight'],
      prefAirSource: map['prefAirSource'],
      dealCode: map['dealCode'],
      selectedFlight: map['selectedFlight'] != null
          ? List<AirLatestFlightDetailsSearch>.from(map['selectedFlight']
              ?.map((x) => AirLatestFlightDetailsSearch.fromMap(x)))
          : null,
      otherData: map['otherData'] != null
          ? Map<String, Object>.from(map['otherData'])
          : null,
      passengerDetails: map['passengerDetails'] != null
          ? List<PassengerDetails>.from(
              map['passengerDetails']?.map((x) => PassengerDetails.fromMap(x)))
          : null,
      segmentRefFrom: map['segmentRefFrom'],
      segmentRefTo: map['segmentRefTo'],
      cartId: map['cartId'],
      hold: map['hold'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingRequest.fromJson(String source) =>
      BookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingRequest(formOfPayment: $formOfPayment, contactNumber: $contactNumber, email: $email, gstEmail: $gstEmail, gstNumber: $gstNumber, billingEntity: $billingEntity, gstBookingDetails: $gstBookingDetails, runtimeMarkUp: $runtimeMarkUp, errorDetails: $errorDetails, isInternational: $isInternational, isDomestic: $isDomestic, paxCount: $paxCount, adultCount: $adultCount, childCount: $childCount, infantCount: $infantCount, requestId: $requestId, userBookingContext: $userBookingContext, prefAirline: $prefAirline, travelType: $travelType, journeyType: $journeyType, directFlight: $directFlight, prefAirSource: $prefAirSource, dealCode: $dealCode, selectedFlight: $selectedFlight, otherData: $otherData, passengerDetails: $passengerDetails, segmentRefFrom: $segmentRefFrom, segmentRefTo: $segmentRefTo, cartId: $cartId, hold: $hold)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BookingRequest &&
        other.formOfPayment == formOfPayment &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstEmail == gstEmail &&
        other.gstNumber == gstNumber &&
        other.billingEntity == billingEntity &&
        other.gstBookingDetails == gstBookingDetails &&
        listEquals(other.runtimeMarkUp, runtimeMarkUp) &&
        other.errorDetails == errorDetails &&
        other.isInternational == isInternational &&
        other.isDomestic == isDomestic &&
        other.paxCount == paxCount &&
        other.adultCount == adultCount &&
        other.childCount == childCount &&
        other.infantCount == infantCount &&
        other.requestId == requestId &&
        other.userBookingContext == userBookingContext &&
        other.prefAirline == prefAirline &&
        other.travelType == travelType &&
        other.journeyType == journeyType &&
        other.directFlight == directFlight &&
        other.prefAirSource == prefAirSource &&
        other.dealCode == dealCode &&
        listEquals(other.selectedFlight, selectedFlight) &&
        mapEquals(other.otherData, otherData) &&
        listEquals(other.passengerDetails, passengerDetails) &&
        other.segmentRefFrom == segmentRefFrom &&
        other.segmentRefTo == segmentRefTo &&
        other.cartId == cartId &&
        other.hold == hold;
  }

  @override
  int get hashCode {
    return formOfPayment.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstEmail.hashCode ^
        gstNumber.hashCode ^
        billingEntity.hashCode ^
        gstBookingDetails.hashCode ^
        runtimeMarkUp.hashCode ^
        errorDetails.hashCode ^
        isInternational.hashCode ^
        isDomestic.hashCode ^
        paxCount.hashCode ^
        adultCount.hashCode ^
        childCount.hashCode ^
        infantCount.hashCode ^
        requestId.hashCode ^
        userBookingContext.hashCode ^
        prefAirline.hashCode ^
        travelType.hashCode ^
        journeyType.hashCode ^
        directFlight.hashCode ^
        prefAirSource.hashCode ^
        dealCode.hashCode ^
        selectedFlight.hashCode ^
        otherData.hashCode ^
        passengerDetails.hashCode ^
        segmentRefFrom.hashCode ^
        segmentRefTo.hashCode ^
        cartId.hashCode ^
        hold.hashCode;
  }
}
