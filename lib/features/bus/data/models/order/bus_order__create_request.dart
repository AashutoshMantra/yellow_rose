import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/order/bus_booking_request.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/booking_channel_enum.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/duper_valdiation.dart';
import 'package:yellow_rose/features/flight/data/models/payment.dart';

class BusOrderCreateRequest {
  final String? orderId;
  final String? requestUuid;
  final String? requestId;
  final String? paymentMedium;
  final String? cardNo;
  final String? inventoryId;
  final bool? ticketIssuance = false;
  final DupeValidation? dupeValidation;
  final BookingChannelEnum? channel;
  final List<UserBusBookingRequest>? busBooking;
  final BusBookingRequest? bookingRequest;
  // final TravellerDetail travellerDetails;
  final String? cardDetails;
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
  final String? cartId;
  final String? branch;
  final int whiteLabelId;
  final String? tripUid;
  final String? customerCardDetails;
  final String? passThroughCardDetails;
  final bool? repriceStatus;
  final bool? dobMandatory = false;
  final String? source;
  final String? destination;
  final String? sourceId;
  final String? destinationId;
  BusOrderCreateRequest({
    this.orderId,
    this.requestUuid,
    this.requestId,
    this.paymentMedium,
    this.cardNo,
    this.inventoryId,
    this.dupeValidation,
    this.channel = BookingChannelEnum.APP,
    this.busBooking,
    this.bookingRequest,
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
    this.cartId,
    this.branch,
    required this.whiteLabelId,
    this.tripUid,
    this.customerCardDetails,
    this.passThroughCardDetails,
    this.repriceStatus,
    this.source,
    this.destination,
    this.sourceId,
    this.destinationId,
  });

  BusOrderCreateRequest copyWith({
    String? orderId,
    String? requestUuid,
    String? requestId,
    String? paymentMedium,
    String? cardNo,
    String? inventoryId,
    DupeValidation? dupeValidation,
    BookingChannelEnum? channel,
    List<UserBusBookingRequest>? busBooking,
    BusBookingRequest? bookingRequest,
    String? cardDetails,
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
    String? cartId,
    String? branch,
    int? whiteLabelId,
    String? tripUid,
    String? customerCardDetails,
    String? passThroughCardDetails,
    bool? repriceStatus,
    String? source,
    String? destination,
    String? sourceId,
    String? destinationId,
  }) {
    return BusOrderCreateRequest(
      orderId: orderId ?? this.orderId,
      requestUuid: requestUuid ?? this.requestUuid,
      requestId: requestId ?? this.requestId,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      cardNo: cardNo ?? this.cardNo,
      inventoryId: inventoryId ?? this.inventoryId,
      dupeValidation: dupeValidation ?? this.dupeValidation,
      channel: channel ?? this.channel,
      busBooking: busBooking ?? this.busBooking,
      bookingRequest: bookingRequest ?? this.bookingRequest,
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
      cartId: cartId ?? this.cartId,
      branch: branch ?? this.branch,
      whiteLabelId: whiteLabelId ?? this.whiteLabelId,
      tripUid: tripUid ?? this.tripUid,
      customerCardDetails: customerCardDetails ?? this.customerCardDetails,
      passThroughCardDetails:
          passThroughCardDetails ?? this.passThroughCardDetails,
      repriceStatus: repriceStatus ?? this.repriceStatus,
      source: source ?? this.source,
      destination: destination ?? this.destination,
      sourceId: sourceId ?? this.sourceId,
      destinationId: destinationId ?? this.destinationId,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (requestUuid != null) {
      result.addAll({'requestUuid': requestUuid});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (cardNo != null) {
      result.addAll({'cardNo': cardNo});
    }
    if (inventoryId != null) {
      result.addAll({'inventoryId': inventoryId});
    }
    if (dupeValidation != null) {
      result.addAll({'dupeValidation': dupeValidation!.toMap()});
    }
    if (channel != null) {
      result.addAll({'channel': channel!.code});
    }
    if (busBooking != null) {
      result.addAll({'busBooking': busBooking!.map((x) => x.toMap()).toList()});
    }
    if (bookingRequest != null) {
      result.addAll({'bookingRequest': bookingRequest!.toMap()});
    }
    if (cardDetails != null) {
      result.addAll({'cardDetails': cardDetails});
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
    if (cartId != null) {
      result.addAll({'cartId': cartId});
    }
    if (branch != null) {
      result.addAll({'branch': branch});
    }
    result.addAll({'whiteLabelId': whiteLabelId});
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }
    if (customerCardDetails != null) {
      result.addAll({'customerCardDetails': customerCardDetails});
    }
    if (passThroughCardDetails != null) {
      result.addAll({'passThroughCardDetails': passThroughCardDetails});
    }
    if (repriceStatus != null) {
      result.addAll({'repriceStatus': repriceStatus});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    if (destination != null) {
      result.addAll({'destination': destination});
    }
    if (sourceId != null) {
      result.addAll({'sourceId': sourceId});
    }
    if (destinationId != null) {
      result.addAll({'destinationId': destinationId});
    }

    return result;
  }

  factory BusOrderCreateRequest.fromMap(Map<String, dynamic> map) {
    return BusOrderCreateRequest(
      orderId: map['orderId'],
      requestUuid: map['requestUuid'],
      requestId: map['requestId'],
      paymentMedium: map['paymentMedium'],
      cardNo: map['cardNo'],
      inventoryId: map['inventoryId'],
      dupeValidation: map['dupeValidation'] != null
          ? DupeValidation.fromMap(map['dupeValidation'])
          : null,
      channel: BookingChannelEnum.APP,
      busBooking: map['busBooking'] != null
          ? List<UserBusBookingRequest>.from(
              map['busBooking']?.map((x) => UserBusBookingRequest.fromMap(x)))
          : null,
      bookingRequest: map['bookingRequest'] != null
          ? BusBookingRequest.fromMap(map['bookingRequest'])
          : null,
      cardDetails: map['cardDetails'],
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
      cartId: map['cartId'],
      branch: map['branch'],
      whiteLabelId: map['whiteLabelId']?.toInt() ?? 0,
      tripUid: map['tripUid'],
      customerCardDetails: map['customerCardDetails'],
      passThroughCardDetails: map['passThroughCardDetails'],
      repriceStatus: map['repriceStatus'],
      source: map['source'],
      destination: map['destination'],
      sourceId: map['sourceId'],
      destinationId: map['destinationId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusOrderCreateRequest.fromJson(String source) =>
      BusOrderCreateRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderCreateRequest(orderId: $orderId, requestUuid: $requestUuid, requestId: $requestId, paymentMedium: $paymentMedium, cardNo: $cardNo, inventoryId: $inventoryId, dupeValidation: $dupeValidation, channel: $channel, busBooking: $busBooking, bookingRequest: $bookingRequest, cardDetails: $cardDetails, contactNumber: $contactNumber, email: $email, gstNumber: $gstNumber, billingEntity: $billingEntity, gstEmail: $gstEmail, payment: $payment, bookedFor: $bookedFor, bookedBy: $bookedBy, bookingUser: $bookingUser, userUid: $userUid, cartId: $cartId, branch: $branch, whiteLabelId: $whiteLabelId, tripUid: $tripUid, customerCardDetails: $customerCardDetails, passThroughCardDetails: $passThroughCardDetails, repriceStatus: $repriceStatus, source: $source, destination: $destination, sourceId: $sourceId, destinationId: $destinationId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderCreateRequest &&
        other.orderId == orderId &&
        other.requestUuid == requestUuid &&
        other.requestId == requestId &&
        other.paymentMedium == paymentMedium &&
        other.cardNo == cardNo &&
        other.inventoryId == inventoryId &&
        other.dupeValidation == dupeValidation &&
        other.channel == channel &&
        listEquals(other.busBooking, busBooking) &&
        other.bookingRequest == bookingRequest &&
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
        other.cartId == cartId &&
        other.branch == branch &&
        other.whiteLabelId == whiteLabelId &&
        other.tripUid == tripUid &&
        other.customerCardDetails == customerCardDetails &&
        other.passThroughCardDetails == passThroughCardDetails &&
        other.repriceStatus == repriceStatus &&
        other.source == source &&
        other.destination == destination &&
        other.sourceId == sourceId &&
        other.destinationId == destinationId;
  }

  @override
  int get hashCode {
    return orderId.hashCode ^
        requestUuid.hashCode ^
        requestId.hashCode ^
        paymentMedium.hashCode ^
        cardNo.hashCode ^
        inventoryId.hashCode ^
        dupeValidation.hashCode ^
        channel.hashCode ^
        busBooking.hashCode ^
        bookingRequest.hashCode ^
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
        cartId.hashCode ^
        branch.hashCode ^
        whiteLabelId.hashCode ^
        tripUid.hashCode ^
        customerCardDetails.hashCode ^
        passThroughCardDetails.hashCode ^
        repriceStatus.hashCode ^
        source.hashCode ^
        destination.hashCode ^
        sourceId.hashCode ^
        destinationId.hashCode;
  }
}
