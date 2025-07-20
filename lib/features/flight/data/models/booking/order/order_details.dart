import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/airsearch/air_search_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/card.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/booking_channel_enum.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/duper_valdiation.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_error_handler.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_traveller_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/user_booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/payment.dart';

class OrderDetails {
  final String? orderId;
  final String? pnr;
  final String? paymentMedium;
  final bool? ticketIssuance = true;
  final String? requestUuid;
  final DupeValidation? dupeValidation;
  final BookingChannelEnum? channel = BookingChannelEnum.APP;
  final AirSearchRequest? airSearchRequest;
  final List<UserBookingRequest>? flightBooking;
  final BookingRequest? bookingRequest;
  final OrderTravellerDetails? travellerDetails;
  final Card? cardDetails;
  final String? contactNumber;
  final String? email;
  final String? gstNumber;
  final String? billingEntity;
  final String? gstEmail;
  final Payment? payment;
  final String? bookedFor;
  final String? bookedBy;
  final String? bookingUser;
  final String? userUid;
  final String? branch;
  final String? customerCardDetails;
  final String? passThroughCardDetails;
  final int? whiteLabelId;
  final String? tripUid;
  final bool? repriceStatus;
  final List<OrderErrorHandler>? errorDetails;
  OrderDetails({
    this.orderId,
    this.pnr,
    this.paymentMedium,
    this.requestUuid,
    this.dupeValidation,
    this.airSearchRequest,
    this.flightBooking,
    this.bookingRequest,
    this.travellerDetails,
    this.cardDetails,
    this.contactNumber,
    this.email,
    this.gstNumber,
    this.billingEntity,
    this.gstEmail,
    this.payment,
    this.bookedFor,
    this.bookedBy,
    this.bookingUser,
    this.userUid,
    this.branch,
    this.customerCardDetails,
    this.passThroughCardDetails,
    this.whiteLabelId,
    this.tripUid,
    this.repriceStatus,
    this.errorDetails,
  });

  OrderDetails copyWith({
    String? orderId,
    String? pnr,
    String? paymentMedium,
    String? requestUuid,
    DupeValidation? dupeValidation,
    AirSearchRequest? airSearchRequest,
    List<UserBookingRequest>? flightBooking,
    BookingRequest? bookingRequest,
    OrderTravellerDetails? travellerDetails,
    Card? cardDetails,
    String? contactNumber,
    String? email,
    String? gstNumber,
    String? billingEntity,
    String? gstEmail,
    Payment? payment,
    String? bookedFor,
    String? bookedBy,
    String? bookingUser,
    String? userUid,
    String? branch,
    String? customerCardDetails,
    String? passThroughCardDetails,
    int? whiteLabelId,
    String? tripUid,
    bool? repriceStatus,
    List<OrderErrorHandler>? errorDetails,
  }) {
    return OrderDetails(
      orderId: orderId ?? this.orderId,
      pnr: pnr ?? this.pnr,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      requestUuid: requestUuid ?? this.requestUuid,
      dupeValidation: dupeValidation ?? this.dupeValidation,
      airSearchRequest: airSearchRequest ?? this.airSearchRequest,
      flightBooking: flightBooking ?? this.flightBooking,
      bookingRequest: bookingRequest ?? this.bookingRequest,
      travellerDetails: travellerDetails ?? this.travellerDetails,
      cardDetails: cardDetails ?? this.cardDetails,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstNumber: gstNumber ?? this.gstNumber,
      billingEntity: billingEntity ?? this.billingEntity,
      gstEmail: gstEmail ?? this.gstEmail,
      payment: payment ?? this.payment,
      bookedFor: bookedFor ?? this.bookedFor,
      bookedBy: bookedBy ?? this.bookedBy,
      bookingUser: bookingUser ?? this.bookingUser,
      userUid: userUid ?? this.userUid,
      branch: branch ?? this.branch,
      customerCardDetails: customerCardDetails ?? this.customerCardDetails,
      passThroughCardDetails:
          passThroughCardDetails ?? this.passThroughCardDetails,
      whiteLabelId: whiteLabelId ?? this.whiteLabelId,
      tripUid: tripUid ?? this.tripUid,
      repriceStatus: repriceStatus ?? this.repriceStatus,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (requestUuid != null) {
      result.addAll({'requestUuid': requestUuid});
    }
    if (dupeValidation != null) {
      result.addAll({'dupeValidation': dupeValidation!.toMap()});
    }
    if (airSearchRequest != null) {
      result.addAll({'airSearchRequest': airSearchRequest!.toMap()});
    }
    if (flightBooking != null) {
      result.addAll(
          {'flightBooking': flightBooking!.map((x) => x.toMap()).toList()});
    }
    if (bookingRequest != null) {
      result.addAll({'bookingRequest': bookingRequest!.toMap()});
    }
    if (travellerDetails != null) {
      result.addAll({'travellerDetails': travellerDetails!.toMap()});
    }
    if (cardDetails != null) {
      result.addAll({'cardDetails': cardDetails!.toMap()});
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
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (gstEmail != null) {
      result.addAll({'gstEmail': gstEmail});
    }
    if (payment != null) {
      result.addAll({'payment': payment!.toMap()});
    }
    if (bookedFor != null) {
      result.addAll({'bookedFor': bookedFor});
    }
    if (bookedBy != null) {
      result.addAll({'bookedBy': bookedBy});
    }
    if (bookingUser != null) {
      result.addAll({'bookingUser': bookingUser});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (branch != null) {
      result.addAll({'branch': branch});
    }
    if (customerCardDetails != null) {
      result.addAll({'customerCardDetails': customerCardDetails});
    }
    if (passThroughCardDetails != null) {
      result.addAll({'passThroughCardDetails': passThroughCardDetails});
    }
    if (whiteLabelId != null) {
      result.addAll({'whiteLabelId': whiteLabelId});
    }
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }
    if (repriceStatus != null) {
      result.addAll({'repriceStatus': repriceStatus});
    }
    if (errorDetails != null) {
      result.addAll(
          {'errorDetails': errorDetails!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      orderId: map['orderId'],
      pnr: map['pnr'],
      paymentMedium: map['paymentMedium'],
      requestUuid: map['requestUuid'],
      dupeValidation: map['dupeValidation'] != null
          ? DupeValidation.fromMap(map['dupeValidation'])
          : null,
      airSearchRequest: map['airSearchRequest'] != null
          ? AirSearchRequest.fromMap(map['airSearchRequest'])
          : null,
      flightBooking: map['flightBooking'] != null
          ? List<UserBookingRequest>.from(
              map['flightBooking']?.map((x) => UserBookingRequest.fromMap(x)))
          : null,
      bookingRequest: map['bookingRequest'] != null
          ? BookingRequest.fromMap(map['bookingRequest'])
          : null,
      travellerDetails: map['travellerDetails'] != null
          ? OrderTravellerDetails.fromMap(map['travellerDetails'])
          : null,
      cardDetails:
          map['cardDetails'] != null ? Card.fromMap(map['cardDetails']) : null,
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstNumber: map['gstNumber'],
      billingEntity: map['billingEntity'],
      gstEmail: map['gstEmail'],
      payment: map['payment'] != null ? Payment.fromMap(map['payment']) : null,
      bookedFor: map['bookedFor'],
      bookedBy: map['bookedBy'],
      bookingUser: map['bookingUser'],
      userUid: map['userUid'],
      branch: map['branch'],
      customerCardDetails: map['customerCardDetails'],
      passThroughCardDetails: map['passThroughCardDetails'],
      whiteLabelId: map['whiteLabelId']?.toInt(),
      tripUid: map['tripUid'],
      repriceStatus: map['repriceStatus'],
      errorDetails: map['errorDetails'] != null
          ? List<OrderErrorHandler>.from(
              map['errorDetails']?.map((x) => OrderErrorHandler.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderDetails.fromJson(String source) =>
      OrderDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderDetails(orderId: $orderId, pnr: $pnr, paymentMedium: $paymentMedium, requestUuid: $requestUuid, dupeValidation: $dupeValidation, airSearchRequest: $airSearchRequest, flightBooking: $flightBooking, bookingRequest: $bookingRequest, travellerDetails: $travellerDetails, cardDetails: $cardDetails, contactNumber: $contactNumber, email: $email, gstNumber: $gstNumber, billingEntity: $billingEntity, gstEmail: $gstEmail, payment: $payment, bookedFor: $bookedFor, bookedBy: $bookedBy, bookingUser: $bookingUser, userUid: $userUid, branch: $branch, customerCardDetails: $customerCardDetails, passThroughCardDetails: $passThroughCardDetails, whiteLabelId: $whiteLabelId, tripUid: $tripUid, repriceStatus: $repriceStatus, errorDetails: $errorDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderDetails &&
        other.orderId == orderId &&
        other.pnr == pnr &&
        other.paymentMedium == paymentMedium &&
        other.requestUuid == requestUuid &&
        other.dupeValidation == dupeValidation &&
        other.airSearchRequest == airSearchRequest &&
        listEquals(other.flightBooking, flightBooking) &&
        other.bookingRequest == bookingRequest &&
        other.travellerDetails == travellerDetails &&
        other.cardDetails == cardDetails &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstNumber == gstNumber &&
        other.billingEntity == billingEntity &&
        other.gstEmail == gstEmail &&
        other.payment == payment &&
        other.bookedFor == bookedFor &&
        other.bookedBy == bookedBy &&
        other.bookingUser == bookingUser &&
        other.userUid == userUid &&
        other.branch == branch &&
        other.customerCardDetails == customerCardDetails &&
        other.passThroughCardDetails == passThroughCardDetails &&
        other.whiteLabelId == whiteLabelId &&
        other.tripUid == tripUid &&
        other.repriceStatus == repriceStatus &&
        listEquals(other.errorDetails, errorDetails);
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        pnr.hashCode ^
        paymentMedium.hashCode ^
        requestUuid.hashCode ^
        dupeValidation.hashCode ^
        airSearchRequest.hashCode ^
        flightBooking.hashCode ^
        bookingRequest.hashCode ^
        travellerDetails.hashCode ^
        cardDetails.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstNumber.hashCode ^
        billingEntity.hashCode ^
        gstEmail.hashCode ^
        payment.hashCode ^
        bookedFor.hashCode ^
        bookedBy.hashCode ^
        bookingUser.hashCode ^
        userUid.hashCode ^
        branch.hashCode ^
        customerCardDetails.hashCode ^
        passThroughCardDetails.hashCode ^
        whiteLabelId.hashCode ^
        tripUid.hashCode ^
        repriceStatus.hashCode ^
        errorDetails.hashCode;
  }
}
