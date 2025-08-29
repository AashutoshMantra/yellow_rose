import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/order/expedia/expedia_booking_u_i_request_invoicing.dart';
import 'package:yellow_rose/features/hotel/data/models/order/expedia/expedia_booking_u_i_request_payment.dart';
import 'package:yellow_rose/features/hotel/data/models/order/expedia/expedia_booking_u_i_request_room.dart';

class ExpediaBookingUIRequest {
  final int? id;

  final String? requestId;

  final double? finalMarkup;

  final bool hold;

  final String? customerEmail;

  final String? phoneCountryCode = "91";

  final String? phoneAreaCode;

  final String? phoneNumber;

  //final ExpediaPreCheckRespLink bookLink;

  final List<ExpediaBookingUIRequestRoom> rooms;

  final String? taxRegistrationNumber;
  final String? travelerHandlingInstructions;

  final List<ExpediaBookingUIRequestPayment> payments;
  final ExpediaBookingUIRequestInvoicing invoicing;

  final String? ipAddress;
  ExpediaBookingUIRequest({
    this.id,
    this.requestId,
    this.finalMarkup,
    required this.hold,
    this.customerEmail,
    this.phoneAreaCode,
    this.phoneNumber,
    required this.rooms,
    this.taxRegistrationNumber,
    this.travelerHandlingInstructions,
    required this.payments,
    required this.invoicing,
    this.ipAddress,
  });

  ExpediaBookingUIRequest copyWith({
    int? id,
    String? requestId,
    double? finalMarkup,
    bool? hold,
    String? customerEmail,
    String? phoneAreaCode,
    String? phoneNumber,
    List<ExpediaBookingUIRequestRoom>? rooms,
    String? taxRegistrationNumber,
    String? travelerHandlingInstructions,
    List<ExpediaBookingUIRequestPayment>? payments,
    ExpediaBookingUIRequestInvoicing? invoicing,
    String? ipAddress,
  }) {
    return ExpediaBookingUIRequest(
      id: id ?? this.id,
      requestId: requestId ?? this.requestId,
      finalMarkup: finalMarkup ?? this.finalMarkup,
      hold: hold ?? this.hold,
      customerEmail: customerEmail ?? this.customerEmail,
      phoneAreaCode: phoneAreaCode ?? this.phoneAreaCode,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      rooms: rooms ?? this.rooms,
      taxRegistrationNumber: taxRegistrationNumber ?? this.taxRegistrationNumber,
      travelerHandlingInstructions: travelerHandlingInstructions ?? this.travelerHandlingInstructions,
      payments: payments ?? this.payments,
      invoicing: invoicing ?? this.invoicing,
      ipAddress: ipAddress ?? this.ipAddress,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(id != null){
      result.addAll({'id': id});
    }
    if(requestId != null){
      result.addAll({'requestId': requestId});
    }
    if(finalMarkup != null){
      result.addAll({'finalMarkup': finalMarkup});
    }
    result.addAll({'hold': hold});
    if(customerEmail != null){
      result.addAll({'customerEmail': customerEmail});
    }
    if(phoneAreaCode != null){
      result.addAll({'phoneAreaCode': phoneAreaCode});
    }
    if(phoneNumber != null){
      result.addAll({'phoneNumber': phoneNumber});
    }
    result.addAll({'rooms': rooms.map((x) => x.toMap()).toList()});
    if(taxRegistrationNumber != null){
      result.addAll({'taxRegistrationNumber': taxRegistrationNumber});
    }
    if(travelerHandlingInstructions != null){
      result.addAll({'travelerHandlingInstructions': travelerHandlingInstructions});
    }
    result.addAll({'payments': payments.map((x) => x.toMap()).toList()});
    result.addAll({'invoicing': invoicing.toMap()});
    if(ipAddress != null){
      result.addAll({'ipAddress': ipAddress});
    }
  
    return result;
  }

  factory ExpediaBookingUIRequest.fromMap(Map<String, dynamic> map) {
    return ExpediaBookingUIRequest(
      id: map['id']?.toInt(),
      requestId: map['requestId'],
      finalMarkup: map['finalMarkup']?.toDouble(),
      hold: map['hold'] ?? false,
      customerEmail: map['customerEmail'],
      phoneAreaCode: map['phoneAreaCode'],
      phoneNumber: map['phoneNumber'],
      rooms: List<ExpediaBookingUIRequestRoom>.from(map['rooms']?.map((x) => ExpediaBookingUIRequestRoom.fromMap(x))),
      taxRegistrationNumber: map['taxRegistrationNumber'],
      travelerHandlingInstructions: map['travelerHandlingInstructions'],
      payments: List<ExpediaBookingUIRequestPayment>.from(map['payments']?.map((x) => ExpediaBookingUIRequestPayment.fromMap(x))),
      invoicing: ExpediaBookingUIRequestInvoicing.fromMap(map['invoicing']),
      ipAddress: map['ipAddress'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaBookingUIRequest.fromJson(String source) => ExpediaBookingUIRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaBookingUIRequest(id: $id, requestId: $requestId, finalMarkup: $finalMarkup, hold: $hold, customerEmail: $customerEmail, phoneAreaCode: $phoneAreaCode, phoneNumber: $phoneNumber, rooms: $rooms, taxRegistrationNumber: $taxRegistrationNumber, travelerHandlingInstructions: $travelerHandlingInstructions, payments: $payments, invoicing: $invoicing, ipAddress: $ipAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaBookingUIRequest &&
      other.id == id &&
      other.requestId == requestId &&
      other.finalMarkup == finalMarkup &&
      other.hold == hold &&
      other.customerEmail == customerEmail &&
      other.phoneAreaCode == phoneAreaCode &&
      other.phoneNumber == phoneNumber &&
      listEquals(other.rooms, rooms) &&
      other.taxRegistrationNumber == taxRegistrationNumber &&
      other.travelerHandlingInstructions == travelerHandlingInstructions &&
      listEquals(other.payments, payments) &&
      other.invoicing == invoicing &&
      other.ipAddress == ipAddress;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      requestId.hashCode ^
      finalMarkup.hashCode ^
      hold.hashCode ^
      customerEmail.hashCode ^
      phoneAreaCode.hashCode ^
      phoneNumber.hashCode ^
      rooms.hashCode ^
      taxRegistrationNumber.hashCode ^
      travelerHandlingInstructions.hashCode ^
      payments.hashCode ^
      invoicing.hashCode ^
      ipAddress.hashCode;
  }
}
