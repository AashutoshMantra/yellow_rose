import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/bus/data/models/bus_details/bus_seats.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/passenger_detiald.dart';

class BusBookingRequest {
  final String? source;
  final int? sourceId;
  final String? destination;
  final int? destinationId;
  final String? dateOfJourney;
  final String? requestId;
  final int? paxCount;
  final int? adultCount;
  final int? childCount;
  final int? infantCount;
  final String? travelType;
  final String? journeyType;
  final String? dealCode;
  final String? contactNumber;
  final String? email;
  final String? gstEmail;
  final String? gstNumber;
  final String? branch;
  final String? bookedBy;
  final String? bookingUser;
  final int? whiteLabelId;
  final String? billingEntity;
  final String? cardNo;
  final String? channel;
  final String? payment;
  final String? paymentMedium;
  final String? orderId;
  final String? tripUid;
  final String? cartId;
  final String? cardDetails;
  final String? userUid;
  final String? bookedFor;
  final String? requestUuid;
  final String? seatName;
  final String? rmApprovalUpload;
  final double? fare;
  final String? ladiesSeat;
  final List<UserBusBookingRequest>? busBooking;
  final List<BusSeats>? seats;
  final List<PassengerDetails>? passengerDetails;
  // final List<TravellerDetail> travellerDetails;
  final String? dobMandatory;
  final bool? repriceStatus;
  final String? customerCardDetails;
  final String? passThroughCardDetails;
  final Map<String, Object>? otherData;
  BusBookingRequest({
    this.source,
    this.sourceId,
    this.destination,
    this.destinationId,
    this.dateOfJourney,
    this.requestId,
    this.paxCount,
    this.adultCount,
    this.childCount,
    this.infantCount,
    this.travelType,
    this.journeyType,
    this.dealCode,
    this.contactNumber,
    this.email,
    this.gstEmail,
    this.gstNumber,
    this.branch,
    this.bookedBy,
    this.bookingUser,
    this.whiteLabelId,
    this.billingEntity,
    this.cardNo,
    this.channel,
    this.payment,
    this.paymentMedium,
    this.orderId,
    this.tripUid,
    this.cartId,
    this.cardDetails,
    this.userUid,
    this.bookedFor,
    this.requestUuid,
    this.seatName,
    this.rmApprovalUpload,
    this.fare,
    this.ladiesSeat,
    this.busBooking,
    this.seats,
    this.passengerDetails,
    this.dobMandatory,
    this.repriceStatus,
    this.customerCardDetails,
    this.passThroughCardDetails,
    this.otherData,
  });
  final bool? holdBooking = true;

  BusBookingRequest copyWith({
    String? source,
    int? sourceId,
    String? destination,
    int? destinationId,
    String? dateOfJourney,
    String? requestId,
    int? paxCount,
    int? adultCount,
    int? childCount,
    int? infantCount,
    String? travelType,
    String? journeyType,
    String? dealCode,
    String? contactNumber,
    String? email,
    String? gstEmail,
    String? gstNumber,
    String? branch,
    String? bookedBy,
    String? bookingUser,
    int? whiteLabelId,
    String? billingEntity,
    String? cardNo,
    String? channel,
    String? payment,
    String? paymentMedium,
    String? orderId,
    String? tripUid,
    String? cartId,
    String? cardDetails,
    String? userUid,
    String? bookedFor,
    String? requestUuid,
    String? seatName,
    String? rmApprovalUpload,
    double? fare,
    String? ladiesSeat,
    List<UserBusBookingRequest>? busBooking,
    List<BusSeats>? seats,
    List<PassengerDetails>? passengerDetails,
    String? dobMandatory,
    bool? repriceStatus,
    String? customerCardDetails,
    String? passThroughCardDetails,
    Map<String, Object>? otherData,
  }) {
    return BusBookingRequest(
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      destination: destination ?? this.destination,
      destinationId: destinationId ?? this.destinationId,
      dateOfJourney: dateOfJourney ?? this.dateOfJourney,
      requestId: requestId ?? this.requestId,
      paxCount: paxCount ?? this.paxCount,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      infantCount: infantCount ?? this.infantCount,
      travelType: travelType ?? this.travelType,
      journeyType: journeyType ?? this.journeyType,
      dealCode: dealCode ?? this.dealCode,
      contactNumber: contactNumber ?? this.contactNumber,
      email: email ?? this.email,
      gstEmail: gstEmail ?? this.gstEmail,
      gstNumber: gstNumber ?? this.gstNumber,
      branch: branch ?? this.branch,
      bookedBy: bookedBy ?? this.bookedBy,
      bookingUser: bookingUser ?? this.bookingUser,
      whiteLabelId: whiteLabelId ?? this.whiteLabelId,
      billingEntity: billingEntity ?? this.billingEntity,
      cardNo: cardNo ?? this.cardNo,
      channel: channel ?? this.channel,
      payment: payment ?? this.payment,
      paymentMedium: paymentMedium ?? this.paymentMedium,
      orderId: orderId ?? this.orderId,
      tripUid: tripUid ?? this.tripUid,
      cartId: cartId ?? this.cartId,
      cardDetails: cardDetails ?? this.cardDetails,
      userUid: userUid ?? this.userUid,
      bookedFor: bookedFor ?? this.bookedFor,
      requestUuid: requestUuid ?? this.requestUuid,
      seatName: seatName ?? this.seatName,
      rmApprovalUpload: rmApprovalUpload ?? this.rmApprovalUpload,
      fare: fare ?? this.fare,
      ladiesSeat: ladiesSeat ?? this.ladiesSeat,
      busBooking: busBooking ?? this.busBooking,
      seats: seats ?? this.seats,
      passengerDetails: passengerDetails ?? this.passengerDetails,
      dobMandatory: dobMandatory ?? this.dobMandatory,
      repriceStatus: repriceStatus ?? this.repriceStatus,
      customerCardDetails: customerCardDetails ?? this.customerCardDetails,
      passThroughCardDetails:
          passThroughCardDetails ?? this.passThroughCardDetails,
      otherData: otherData ?? this.otherData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (source != null) {
      result.addAll({'source': source});
    }
    if (sourceId != null) {
      result.addAll({'sourceId': sourceId});
    }
    if (destination != null) {
      result.addAll({'destination': destination});
    }
    if (destinationId != null) {
      result.addAll({'destinationId': destinationId});
    }
    if (dateOfJourney != null) {
      result.addAll({'dateOfJourney': dateOfJourney});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
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
    if (travelType != null) {
      result.addAll({'travelType': travelType});
    }
    if (journeyType != null) {
      result.addAll({'journeyType': journeyType});
    }
    if (dealCode != null) {
      result.addAll({'dealCode': dealCode});
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
    if (branch != null) {
      result.addAll({'branch': branch});
    }
    if (bookedBy != null) {
      result.addAll({'bookedBy': bookedBy});
    }
    if (bookingUser != null) {
      result.addAll({'bookingUser': bookingUser});
    }
    if (whiteLabelId != null) {
      result.addAll({'whiteLabelId': whiteLabelId});
    }
    if (billingEntity != null) {
      result.addAll({'billingEntity': billingEntity});
    }
    if (cardNo != null) {
      result.addAll({'cardNo': cardNo});
    }
    if (channel != null) {
      result.addAll({'channel': channel});
    }
    if (payment != null) {
      result.addAll({'payment': payment});
    }
    if (paymentMedium != null) {
      result.addAll({'paymentMedium': paymentMedium});
    }
    if (orderId != null) {
      result.addAll({'orderId': orderId});
    }
    if (tripUid != null) {
      result.addAll({'tripUid': tripUid});
    }
    if (cartId != null) {
      result.addAll({'cartId': cartId});
    }
    if (cardDetails != null) {
      result.addAll({'cardDetails': cardDetails});
    }
    if (userUid != null) {
      result.addAll({'userUid': userUid});
    }
    if (bookedFor != null) {
      result.addAll({'bookedFor': bookedFor});
    }
    if (requestUuid != null) {
      result.addAll({'requestUuid': requestUuid});
    }
    if (seatName != null) {
      result.addAll({'seatName': seatName});
    }
    if (rmApprovalUpload != null) {
      result.addAll({'rmApprovalUpload': rmApprovalUpload});
    }
    if (fare != null) {
      result.addAll({'fare': fare});
    }
    if (ladiesSeat != null) {
      result.addAll({'ladiesSeat': ladiesSeat});
    }
    if (busBooking != null) {
      result.addAll({'busBooking': busBooking!.map((x) => x.toMap()).toList()});
    }
    if (seats != null) {
      result.addAll({'seats': seats!.map((x) => x.toMap()).toList()});
    }
    if (passengerDetails != null) {
      result.addAll({
        'passengerDetails': passengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (dobMandatory != null) {
      result.addAll({'dobMandatory': dobMandatory});
    }
    if (repriceStatus != null) {
      result.addAll({'repriceStatus': repriceStatus});
    }
    if (customerCardDetails != null) {
      result.addAll({'customerCardDetails': customerCardDetails});
    }
    if (passThroughCardDetails != null) {
      result.addAll({'passThroughCardDetails': passThroughCardDetails});
    }
    result.addAll({'otherData': otherData});

    return result;
  }

  factory BusBookingRequest.fromMap(Map<String, dynamic> map) {
    return BusBookingRequest(
      source: map['source'],
      sourceId: map['sourceId']?.toInt(),
      destination: map['destination'],
      destinationId: map['destinationId']?.toInt(),
      dateOfJourney: map['dateOfJourney'],
      requestId: map['requestId'],
      paxCount: map['paxCount']?.toInt(),
      adultCount: map['adultCount']?.toInt(),
      childCount: map['childCount']?.toInt(),
      infantCount: map['infantCount']?.toInt(),
      travelType: map['travelType'],
      journeyType: map['journeyType'],
      dealCode: map['dealCode'],
      contactNumber: map['contactNumber'],
      email: map['email'],
      gstEmail: map['gstEmail'],
      gstNumber: map['gstNumber'],
      branch: map['branch'],
      bookedBy: map['bookedBy'],
      bookingUser: map['bookingUser'],
      whiteLabelId: map['whiteLabelId']?.toInt(),
      billingEntity: map['billingEntity'],
      cardNo: map['cardNo'],
      channel: map['channel'],
      payment: map['payment'],
      paymentMedium: map['paymentMedium'],
      orderId: map['orderId'],
      tripUid: map['tripUid'],
      cartId: map['cartId'],
      cardDetails: map['cardDetails'],
      userUid: map['userUid'],
      bookedFor: map['bookedFor'],
      requestUuid: map['requestUuid'],
      seatName: map['seatName'],
      rmApprovalUpload: map['rmApprovalUpload'],
      fare: map['fare']?.toDouble(),
      ladiesSeat: map['ladiesSeat'],
      busBooking: List<UserBusBookingRequest>.from(
          map['busBooking']?.map((x) => UserBusBookingRequest.fromMap(x))),
      seats: List<BusSeats>.from(map['seats']?.map((x) => BusSeats.fromMap(x))),
      passengerDetails: List<PassengerDetails>.from(
          map['passengerDetails']?.map((x) => PassengerDetails.fromMap(x))),
      dobMandatory: map['dobMandatory'],
      repriceStatus: map['repriceStatus'],
      customerCardDetails: map['customerCardDetails'],
      passThroughCardDetails: map['passThroughCardDetails'],
      otherData: Map<String, Object>.from(map['otherData']),
    );
  }

  String toJson() => json.encode(toMap());

  factory BusBookingRequest.fromJson(String source) =>
      BusBookingRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusBookingRequest(source: $source, sourceId: $sourceId, destination: $destination, destinationId: $destinationId, dateOfJourney: $dateOfJourney, requestId: $requestId, paxCount: $paxCount, adultCount: $adultCount, childCount: $childCount, infantCount: $infantCount, travelType: $travelType, journeyType: $journeyType, dealCode: $dealCode, contactNumber: $contactNumber, email: $email, gstEmail: $gstEmail, gstNumber: $gstNumber, branch: $branch, bookedBy: $bookedBy, bookingUser: $bookingUser, whiteLabelId: $whiteLabelId, billingEntity: $billingEntity, cardNo: $cardNo, channel: $channel, payment: $payment, paymentMedium: $paymentMedium, orderId: $orderId, tripUid: $tripUid, cartId: $cartId, cardDetails: $cardDetails, userUid: $userUid, bookedFor: $bookedFor, requestUuid: $requestUuid, seatName: $seatName, rmApprovalUpload: $rmApprovalUpload, fare: $fare, ladiesSeat: $ladiesSeat, busBooking: $busBooking, seats: $seats, passengerDetails: $passengerDetails, dobMandatory: $dobMandatory, repriceStatus: $repriceStatus, customerCardDetails: $customerCardDetails, passThroughCardDetails: $passThroughCardDetails, otherData: $otherData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusBookingRequest &&
        other.source == source &&
        other.sourceId == sourceId &&
        other.destination == destination &&
        other.destinationId == destinationId &&
        other.dateOfJourney == dateOfJourney &&
        other.requestId == requestId &&
        other.paxCount == paxCount &&
        other.adultCount == adultCount &&
        other.childCount == childCount &&
        other.infantCount == infantCount &&
        other.travelType == travelType &&
        other.journeyType == journeyType &&
        other.dealCode == dealCode &&
        other.contactNumber == contactNumber &&
        other.email == email &&
        other.gstEmail == gstEmail &&
        other.gstNumber == gstNumber &&
        other.branch == branch &&
        other.bookedBy == bookedBy &&
        other.bookingUser == bookingUser &&
        other.whiteLabelId == whiteLabelId &&
        other.billingEntity == billingEntity &&
        other.cardNo == cardNo &&
        other.channel == channel &&
        other.payment == payment &&
        other.paymentMedium == paymentMedium &&
        other.orderId == orderId &&
        other.tripUid == tripUid &&
        other.cartId == cartId &&
        other.cardDetails == cardDetails &&
        other.userUid == userUid &&
        other.bookedFor == bookedFor &&
        other.requestUuid == requestUuid &&
        other.seatName == seatName &&
        other.rmApprovalUpload == rmApprovalUpload &&
        other.fare == fare &&
        other.ladiesSeat == ladiesSeat &&
        listEquals(other.busBooking, busBooking) &&
        listEquals(other.seats, seats) &&
        listEquals(other.passengerDetails, passengerDetails) &&
        other.dobMandatory == dobMandatory &&
        other.repriceStatus == repriceStatus &&
        other.customerCardDetails == customerCardDetails &&
        other.passThroughCardDetails == passThroughCardDetails &&
        mapEquals(other.otherData, otherData);
  }

  @override
  int get hashCode {
    return source.hashCode ^
        sourceId.hashCode ^
        destination.hashCode ^
        destinationId.hashCode ^
        dateOfJourney.hashCode ^
        requestId.hashCode ^
        paxCount.hashCode ^
        adultCount.hashCode ^
        childCount.hashCode ^
        infantCount.hashCode ^
        travelType.hashCode ^
        journeyType.hashCode ^
        dealCode.hashCode ^
        contactNumber.hashCode ^
        email.hashCode ^
        gstEmail.hashCode ^
        gstNumber.hashCode ^
        branch.hashCode ^
        bookedBy.hashCode ^
        bookingUser.hashCode ^
        whiteLabelId.hashCode ^
        billingEntity.hashCode ^
        cardNo.hashCode ^
        channel.hashCode ^
        payment.hashCode ^
        paymentMedium.hashCode ^
        orderId.hashCode ^
        tripUid.hashCode ^
        cartId.hashCode ^
        cardDetails.hashCode ^
        userUid.hashCode ^
        bookedFor.hashCode ^
        requestUuid.hashCode ^
        seatName.hashCode ^
        rmApprovalUpload.hashCode ^
        fare.hashCode ^
        ladiesSeat.hashCode ^
        busBooking.hashCode ^
        seats.hashCode ^
        passengerDetails.hashCode ^
        dobMandatory.hashCode ^
        repriceStatus.hashCode ^
        customerCardDetails.hashCode ^
        passThroughCardDetails.hashCode ^
        otherData.hashCode;
  }
}
