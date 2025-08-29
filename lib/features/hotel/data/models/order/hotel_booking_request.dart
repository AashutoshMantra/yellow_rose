import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_commercial.dart';
import 'package:yellow_rose/features/hotel/data/models/order/expedia/expedia_booking_request.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_confirmation_post_booking.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel_traveller.dart';
import 'package:yellow_rose/features/hotel/data/models/order/mmt/mmt_booking_request.dart';

class HotelBookingRequest {
  final List<MmtBookingRequest> mmtBookingRequestList;
  final List<ExpediaBookingUIRequest> expediaBookingRequestList;
  final String? contactNumber;
  final String? email;
  final String? gstEmail;
  final String? gstNumber;
  final String? billingEntity;
  final String? specialRequest;
  final HotelConfirmationPostBooking? hotelConfirmation;
  final List<PassengerDetails> passengerDetails;
  final HotelDetailCommercial? runtimeMarkUp;
  final ErrorCodeHandler? errorDetails;

  final String? source;
  final String? requestId;
  final String? currency;
  final List<HotelTraveler>? travellers;
  HotelBookingRequest({
    required this.mmtBookingRequestList,
    required this.expediaBookingRequestList,
    this.contactNumber,
    this.email,
    this.gstEmail,
    this.gstNumber,
    this.billingEntity,
    this.specialRequest,
    this.hotelConfirmation,
    required this.passengerDetails,
    this.runtimeMarkUp,
    this.errorDetails,
    this.source,
    this.requestId,
    this.currency,
    this.travellers,
  });

  HotelBookingRequest copyWith({
    List<MmtBookingRequest>? mmtBookingRequestList,
    List<ExpediaBookingUIRequest>? expediaBookingRequestList,
    String? contactNumber,
    String? email,
    String? gstEmail,
    String? gstNumber,
    String? billingEntity,
    String? specialRequest,
    HotelConfirmationPostBooking? hotelConfirmation,
    List<PassengerDetails>? passengerDetails,
    HotelDetailCommercial? runtimeMarkUp,
    ErrorCodeHandler? errorDetails,
    String? source,
    String? requestId,
    String? currency,
    List<HotelTraveler>? travellers,
  }) {
    return HotelBookingRequest(
      mmtBookingRequestList:
          mmtBookingRequestList ?? this.mmtBookingRequestList,
      expediaBookingRequestList:
          expediaBookingRequestList ?? this.expediaBookingRequestList,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstEmail: gstEmail ?? this.gstEmail,
      gstNumber: gstNumber ?? this.gstNumber,
      billingEntity: billingEntity ?? this.billingEntity,
      specialRequest: specialRequest ?? this.specialRequest,
      hotelConfirmation: hotelConfirmation ?? this.hotelConfirmation,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      runtimeMarkUp: runtimeMarkUp ?? this.runtimeMarkUp,
      errorDetails: errorDetails ?? this.errorDetails,
      source: source ?? this.source,
      requestId: requestId ?? this.requestId,
      currency: currency ?? this.currency,
      travellers: travellers ?? this.travellers,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'mmtBookingRequestList': mmtBookingRequestList.map((x) => x.toMap()).toList()});
    result.addAll({'expediaBookingRequestList': expediaBookingRequestList.map((x) => x.toMap()).toList()});
    if(contactNumber != null){
      result.addAll({'contactNumber': contactNumber});
    }
    if(email != null){
      result.addAll({'email': email});
    }
    if(gstEmail != null){
      result.addAll({'gstEmail': gstEmail});
    }
    if(gstNumber != null){
      result.addAll({'gstNumber': gstNumber});
    }
    if(billingEntity != null){
      result.addAll({'billingEntity': billingEntity});
    }
    if(specialRequest != null){
      result.addAll({'specialRequest': specialRequest});
    }
    if(hotelConfirmation != null){
      result.addAll({'hotelConfirmation': hotelConfirmation!.toMap()});
    }
    result.addAll({'passengerDetails': passengerDetails.map((x) => x.toMap()).toList()});
    if(runtimeMarkUp != null){
      result.addAll({'runtimeMarkUp': runtimeMarkUp!.toMap()});
    }
    if(errorDetails != null){
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }
    if(source != null){
      result.addAll({'source': source});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
    if(currency != null){
      result.addAll({'currency': currency});
    }
    if(travellers != null){
      result.addAll({'travellers': travellers!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory HotelBookingRequest.fromMap(Map<String, dynamic> map) {
    return HotelBookingRequest(
      mmtBookingRequestList: List<MmtBookingRequest>.from(map['mmtBookingRequestList']?.map((x) => MmtBookingRequest.fromMap(x))),
      expediaBookingRequestList: List<ExpediaBookingUIRequest>.from(map['expediaBookingRequestList']?.map((x) => ExpediaBookingUIRequest.fromMap(x))),
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstEmail: map['gstEmail'],
      gstNumber: map['gstNumber'],
      billingEntity: map['billingEntity'],
      specialRequest: map['specialRequest'],
      hotelConfirmation: map['hotelConfirmation'] != null ? HotelConfirmationPostBooking.fromMap(map['hotelConfirmation']) : null,
      passengerDetails: List<PassengerDetails>.from(map['passengerDetails']?.map((x) => PassengerDetails.fromMap(x))),
      runtimeMarkUp: map['runtimeMarkUp'] != null ? HotelDetailCommercial.fromMap(map['runtimeMarkUp']) : null,
      errorDetails: map['errorDetails'] != null ? ErrorCodeHandler.fromMap(map['errorDetails']) : null,
      source: map['source'],
      requestId: map['requestId'],
      currency: map['currency'],
      travellers: map['travellers'] != null ? List<HotelTraveler>.from(map['travellers']?.map((x) => HotelTraveler.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelBookingRequest.fromJson(String source) =>
      HotelBookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelBookingRequest(mmtBookingRequestList: $mmtBookingRequestList, expediaBookingRequestList: $expediaBookingRequestList, contactNumber: $contactNumber, email: $email, gstEmail: $gstEmail, gstNumber: $gstNumber, billingEntity: $billingEntity, specialRequest: $specialRequest, hotelConfirmation: $hotelConfirmation, passengerDetails: $passengerDetails, runtimeMarkUp: $runtimeMarkUp, errorDetails: $errorDetails, source: $source, requestId: $requestId, currency: $currency, travellers: $travellers)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelBookingRequest &&
        listEquals(other.mmtBookingRequestList, mmtBookingRequestList) &&
        listEquals(
            other.expediaBookingRequestList, expediaBookingRequestList) &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstEmail == gstEmail &&
        other.gstNumber == gstNumber &&
        other.billingEntity == billingEntity &&
        other.specialRequest == specialRequest &&
        other.hotelConfirmation == hotelConfirmation &&
        listEquals(other.passengerDetails, passengerDetails) &&
        other.runtimeMarkUp == runtimeMarkUp &&
        other.errorDetails == errorDetails &&
        other.source == source &&
        other.requestId == requestId &&
        other.currency == currency &&
        listEquals(other.travellers, travellers);
  }

  @override
  int get hashCode {
    return mmtBookingRequestList.hashCode ^
        expediaBookingRequestList.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstEmail.hashCode ^
        gstNumber.hashCode ^
        billingEntity.hashCode ^
        specialRequest.hashCode ^
        hotelConfirmation.hashCode ^
        passengerDetails.hashCode ^
        runtimeMarkUp.hashCode ^
        errorDetails.hashCode ^
        source.hashCode ^
        requestId.hashCode ^
        currency.hashCode ^
        travellers.hashCode;
  }
}
