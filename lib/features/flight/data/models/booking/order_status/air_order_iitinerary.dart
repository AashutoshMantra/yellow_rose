import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/airsearch/air_response_data.dart';
import 'package:yellow_rose/features/flight/data/models/airsearch/flight_detail_with_booking_class.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/order_passenger_details.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order_status/air_booking_status.dart';
import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/flight/data/models/flight_details.dart';

class AirOrderItinerary {
  final int? id;

  final String? uuid;

  final String? orderUuid;

  final String? fromSource;

  final String? toDestination;

  final String? flightNumber;

  final String? airline;

  final String? itineraryType;

  final String? pnr;

  final String? pnrStatus;

  final String? pnrRetrieveResponse;

  final String? pnrRetrieveErrorResponse;

  final String? lastpnrRetrieveStatus;

  final DateTime? lastPnrRetrieveDateTime;

  final String? passiveStatus;

  final String? docIssuanceStatus;

  final String? type;

  final String? sector;

  final String? corporate;

  final AirBookingStatusEnum? status;

  final String? segmentType;

  final String? loginToken;

  final AirBookingStatusEnum? bookingStatus;

  final String? rescheduledItineraryRef;

  final bool? isGrouped;

  final List<OrdersPassengersDetails> orderPassengerDetails;

  //  final List<AirItineraryPayment> payment;

  // final Object dealCode;

  final AirResponseData? flightDetails;

  final ErrorCodeHandler? errorDetails;

  // final Object appliedFareRule;

  final String? paymentReceived;

  //  final Object customerPayment;

  final String? cancellationType;

  final String? rescheduleType;

  // final Object amendmentCharges;

  //  final Object commissionData;

  // final Object externalMarkUpData;

  // final Object internalMarkUpData;

  final String? repriceStatus;

  final DateTime? creationTs;

  final DateTime? firstDeparture;

  final DateTime? modTs;

  final bool? ticketIssuance;

  final bool? ticketIssued;

  final DateTime? bookingTs;

  final DateTime? bookingRequestTs;

  final String? travelDate;
  AirOrderItinerary({
    this.id,
    this.uuid,
    this.orderUuid,
    this.fromSource,
    this.toDestination,
    this.flightNumber,
    this.airline,
    this.itineraryType,
    this.pnr,
    this.pnrStatus,
    this.pnrRetrieveResponse,
    this.pnrRetrieveErrorResponse,
    this.lastpnrRetrieveStatus,
    this.lastPnrRetrieveDateTime,
    this.passiveStatus,
    this.docIssuanceStatus,
    this.type,
    this.sector,
    this.corporate,
    this.status,
    this.segmentType,
    this.loginToken,
    this.bookingStatus,
    this.rescheduledItineraryRef,
    this.isGrouped,
    required this.orderPassengerDetails,
    this.flightDetails,
    this.errorDetails,
    this.paymentReceived,
    this.cancellationType,
    this.rescheduleType,
    this.repriceStatus,
    this.creationTs,
    this.firstDeparture,
    this.modTs,
    this.ticketIssuance,
    this.ticketIssued,
    this.bookingTs,
    this.bookingRequestTs,
    this.travelDate,
  });

  AirOrderItinerary copyWith({
    int? id,
    String? uuid,
    String? orderUuid,
    String? fromSource,
    String? toDestination,
    String? flightNumber,
    String? airline,
    String? itineraryType,
    String? pnr,
    String? pnrStatus,
    String? pnrRetrieveResponse,
    String? pnrRetrieveErrorResponse,
    String? lastpnrRetrieveStatus,
    DateTime? lastPnrRetrieveDateTime,
    String? passiveStatus,
    String? docIssuanceStatus,
    String? type,
    String? sector,
    String? corporate,
    AirBookingStatusEnum? status,
    String? segmentType,
    String? loginToken,
    AirBookingStatusEnum? bookingStatus,
    String? rescheduledItineraryRef,
    bool? isGrouped,
    List<OrdersPassengersDetails>? orderPassengerDetails,
    AirResponseData? flightDetails,
    ErrorCodeHandler? errorDetails,
    String? paymentReceived,
    String? cancellationType,
    String? rescheduleType,
    String? repriceStatus,
    DateTime? creationTs,
    DateTime? firstDeparture,
    DateTime? modTs,
    bool? ticketIssuance,
    bool? ticketIssued,
    DateTime? bookingTs,
    DateTime? bookingRequestTs,
    String? travelDate,
  }) {
    return AirOrderItinerary(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      orderUuid: orderUuid ?? this.orderUuid,
      fromSource: fromSource ?? this.fromSource,
      toDestination: toDestination ?? this.toDestination,
      flightNumber: flightNumber ?? this.flightNumber,
      airline: airline ?? this.airline,
      itineraryType: itineraryType ?? this.itineraryType,
      pnr: pnr ?? this.pnr,
      pnrStatus: pnrStatus ?? this.pnrStatus,
      pnrRetrieveResponse: pnrRetrieveResponse ?? this.pnrRetrieveResponse,
      pnrRetrieveErrorResponse:
          pnrRetrieveErrorResponse ?? this.pnrRetrieveErrorResponse,
      lastpnrRetrieveStatus:
          lastpnrRetrieveStatus ?? this.lastpnrRetrieveStatus,
      lastPnrRetrieveDateTime:
          lastPnrRetrieveDateTime ?? this.lastPnrRetrieveDateTime,
      passiveStatus: passiveStatus ?? this.passiveStatus,
      docIssuanceStatus: docIssuanceStatus ?? this.docIssuanceStatus,
      type: type ?? this.type,
      sector: sector ?? this.sector,
      corporate: corporate ?? this.corporate,
      status: status ?? this.status,
      segmentType: segmentType ?? this.segmentType,
      loginToken: loginToken ?? this.loginToken,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      rescheduledItineraryRef:
          rescheduledItineraryRef ?? this.rescheduledItineraryRef,
      isGrouped: isGrouped ?? this.isGrouped,
      orderPassengerDetails:
          orderPassengerDetails ?? this.orderPassengerDetails,
      flightDetails: flightDetails ?? this.flightDetails,
      errorDetails: errorDetails ?? this.errorDetails,
      paymentReceived: paymentReceived ?? this.paymentReceived,
      cancellationType: cancellationType ?? this.cancellationType,
      rescheduleType: rescheduleType ?? this.rescheduleType,
      repriceStatus: repriceStatus ?? this.repriceStatus,
      creationTs: creationTs ?? this.creationTs,
      firstDeparture: firstDeparture ?? this.firstDeparture,
      modTs: modTs ?? this.modTs,
      ticketIssuance: ticketIssuance ?? this.ticketIssuance,
      ticketIssued: ticketIssued ?? this.ticketIssued,
      bookingTs: bookingTs ?? this.bookingTs,
      bookingRequestTs: bookingRequestTs ?? this.bookingRequestTs,
      travelDate: travelDate ?? this.travelDate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (uuid != null) {
      result.addAll({'uuid': uuid});
    }
    if (orderUuid != null) {
      result.addAll({'orderUuid': orderUuid});
    }
    if (fromSource != null) {
      result.addAll({'fromSource': fromSource});
    }
    if (toDestination != null) {
      result.addAll({'toDestination': toDestination});
    }
    if (flightNumber != null) {
      result.addAll({'flightNumber': flightNumber});
    }
    if (airline != null) {
      result.addAll({'airline': airline});
    }
    if (itineraryType != null) {
      result.addAll({'itineraryType': itineraryType});
    }
    if (pnr != null) {
      result.addAll({'pnr': pnr});
    }
    if (pnrStatus != null) {
      result.addAll({'pnrStatus': pnrStatus});
    }
    if (pnrRetrieveResponse != null) {
      result.addAll({'pnrRetrieveResponse': pnrRetrieveResponse});
    }
    if (pnrRetrieveErrorResponse != null) {
      result.addAll({'pnrRetrieveErrorResponse': pnrRetrieveErrorResponse});
    }
    if (lastpnrRetrieveStatus != null) {
      result.addAll({'lastpnrRetrieveStatus': lastpnrRetrieveStatus});
    }
    if (lastPnrRetrieveDateTime != null) {
      result.addAll({
        'lastPnrRetrieveDateTime':
            lastPnrRetrieveDateTime!.millisecondsSinceEpoch
      });
    }
    if (passiveStatus != null) {
      result.addAll({'passiveStatus': passiveStatus});
    }
    if (docIssuanceStatus != null) {
      result.addAll({'docIssuanceStatus': docIssuanceStatus});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (sector != null) {
      result.addAll({'sector': sector});
    }
    if (corporate != null) {
      result.addAll({'corporate': corporate});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (segmentType != null) {
      result.addAll({'segmentType': segmentType});
    }
    if (loginToken != null) {
      result.addAll({'loginToken': loginToken});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus});
    }
    if (rescheduledItineraryRef != null) {
      result.addAll({'rescheduledItineraryRef': rescheduledItineraryRef});
    }
    if (isGrouped != null) {
      result.addAll({'isGrouped': isGrouped});
    }
    result.addAll({
      'orderPassengerDetails':
          orderPassengerDetails.map((x) => x.toMap()).toList()
    });
    if (flightDetails != null) {
      result.addAll({'flightDetails': flightDetails!.toMap()});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }
    if (paymentReceived != null) {
      result.addAll({'paymentReceived': paymentReceived});
    }
    if (cancellationType != null) {
      result.addAll({'cancellationType': cancellationType});
    }
    if (rescheduleType != null) {
      result.addAll({'rescheduleType': rescheduleType});
    }
    if (repriceStatus != null) {
      result.addAll({'repriceStatus': repriceStatus});
    }
    if (creationTs != null) {
      result.addAll({'creationTs': creationTs!.millisecondsSinceEpoch});
    }
    if (firstDeparture != null) {
      result.addAll({'firstDeparture': firstDeparture!.millisecondsSinceEpoch});
    }
    if (modTs != null) {
      result.addAll({'modTs': modTs!.millisecondsSinceEpoch});
    }
    if (ticketIssuance != null) {
      result.addAll({'ticketIssuance': ticketIssuance});
    }
    if (ticketIssued != null) {
      result.addAll({'ticketIssued': ticketIssued});
    }
    if (bookingTs != null) {
      result.addAll({'bookingTs': bookingTs!.millisecondsSinceEpoch});
    }
    if (bookingRequestTs != null) {
      result.addAll(
          {'bookingRequestTs': bookingRequestTs!.millisecondsSinceEpoch});
    }
    if (travelDate != null) {
      result.addAll({'travelDate': travelDate});
    }

    return result;
  }

  factory AirOrderItinerary.fromMap(Map<String, dynamic> map) {
    return AirOrderItinerary(
      id: map['id']?.toInt(),
      uuid: map['uuid'],
      orderUuid: map['orderUuid'],
      fromSource: map['fromSource'],
      toDestination: map['toDestination'],
      flightNumber: map['flightNumber'],
      airline: map['airline'],
      itineraryType: map['itineraryType'],
      pnr: map['pnr'],
      pnrStatus: map['pnrStatus'],
      pnrRetrieveResponse: map['pnrRetrieveResponse'],
      pnrRetrieveErrorResponse: map['pnrRetrieveErrorResponse'],
      lastpnrRetrieveStatus: map['lastpnrRetrieveStatus'],
      lastPnrRetrieveDateTime: map['lastPnrRetrieveDateTime'] != null
          ? DateTime.tryParse(map['lastPnrRetrieveDateTime'])
          : null,
      passiveStatus: map['passiveStatus'],
      docIssuanceStatus: map['docIssuanceStatus'],
      type: map['type'],
      sector: map['sector'],
      corporate: map['corporate'],
      status: map['status'] != null
          ? AirBookingStatusEnum.getFromCode(map['status'])
          : AirBookingStatusEnum.NEW,
      segmentType: map['segmentType'],
      loginToken: map['loginToken'],
      bookingStatus: map['bookingStatus'] != null
          ? AirBookingStatusEnum.getFromCode(map['bookingStatus'])
          : AirBookingStatusEnum.NEW,
      rescheduledItineraryRef: map['rescheduledItineraryRef'],
      isGrouped: map['isGrouped'],
      orderPassengerDetails: List<OrdersPassengersDetails>.from(
          map['orderPassengerDetails']
              ?.map((x) => OrdersPassengersDetails.fromMap(x))),
      flightDetails: map['flightDetails'] != null
          ? AirResponseData.fromMap(map['flightDetails'])
          : null,
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
      paymentReceived: map['paymentReceived'],
      cancellationType: map['cancellationType'],
      rescheduleType: map['rescheduleType'],
      repriceStatus: map['repriceStatus'],
      creationTs: map['creationTs'] != null
          ? DateTime.tryParse(map['creationTs'])
          : null,
      firstDeparture: map['firstDeparture'] != null
          ? DateTime.tryParse(map['firstDeparture'])
          : null,
      modTs: map['modTs'] != null ? DateTime.tryParse(map['modTs']) : null,
      ticketIssuance: map['ticketIssuance'],
      ticketIssued: map['ticketIssued'],
      bookingTs:
          map['bookingTs'] != null ? DateTime.tryParse(map['bookingTs']) : null,
      bookingRequestTs: map['bookingRequestTs'] != null
          ? DateTime.tryParse(map['bookingRequestTs'])
          : null,
      travelDate: map['travelDate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirOrderItinerary.fromJson(String source) =>
      AirOrderItinerary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AirOrderItinerary(id: $id, uuid: $uuid, orderUuid: $orderUuid, fromSource: $fromSource, toDestination: $toDestination, flightNumber: $flightNumber, airline: $airline, itineraryType: $itineraryType, pnr: $pnr, pnrStatus: $pnrStatus, pnrRetrieveResponse: $pnrRetrieveResponse, pnrRetrieveErrorResponse: $pnrRetrieveErrorResponse, lastpnrRetrieveStatus: $lastpnrRetrieveStatus, lastPnrRetrieveDateTime: $lastPnrRetrieveDateTime, passiveStatus: $passiveStatus, docIssuanceStatus: $docIssuanceStatus, type: $type, sector: $sector, corporate: $corporate, status: $status, segmentType: $segmentType, loginToken: $loginToken, bookingStatus: $bookingStatus, rescheduledItineraryRef: $rescheduledItineraryRef, isGrouped: $isGrouped, orderPassengerDetails: $orderPassengerDetails, flightDetails: $flightDetails, errorDetails: $errorDetails, paymentReceived: $paymentReceived, cancellationType: $cancellationType, rescheduleType: $rescheduleType, repriceStatus: $repriceStatus, creationTs: $creationTs, firstDeparture: $firstDeparture, modTs: $modTs, ticketIssuance: $ticketIssuance, ticketIssued: $ticketIssued, bookingTs: $bookingTs, bookingRequestTs: $bookingRequestTs, travelDate: $travelDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirOrderItinerary &&
        other.id == id &&
        other.uuid == uuid &&
        other.orderUuid == orderUuid &&
        other.fromSource == fromSource &&
        other.toDestination == toDestination &&
        other.flightNumber == flightNumber &&
        other.airline == airline &&
        other.itineraryType == itineraryType &&
        other.pnr == pnr &&
        other.pnrStatus == pnrStatus &&
        other.pnrRetrieveResponse == pnrRetrieveResponse &&
        other.pnrRetrieveErrorResponse == pnrRetrieveErrorResponse &&
        other.lastpnrRetrieveStatus == lastpnrRetrieveStatus &&
        other.lastPnrRetrieveDateTime == lastPnrRetrieveDateTime &&
        other.passiveStatus == passiveStatus &&
        other.docIssuanceStatus == docIssuanceStatus &&
        other.type == type &&
        other.sector == sector &&
        other.corporate == corporate &&
        other.status == status &&
        other.segmentType == segmentType &&
        other.loginToken == loginToken &&
        other.bookingStatus == bookingStatus &&
        other.rescheduledItineraryRef == rescheduledItineraryRef &&
        other.isGrouped == isGrouped &&
        listEquals(other.orderPassengerDetails, orderPassengerDetails) &&
        other.flightDetails == flightDetails &&
        other.errorDetails == errorDetails &&
        other.paymentReceived == paymentReceived &&
        other.cancellationType == cancellationType &&
        other.rescheduleType == rescheduleType &&
        other.repriceStatus == repriceStatus &&
        other.creationTs == creationTs &&
        other.firstDeparture == firstDeparture &&
        other.modTs == modTs &&
        other.ticketIssuance == ticketIssuance &&
        other.ticketIssued == ticketIssued &&
        other.bookingTs == bookingTs &&
        other.bookingRequestTs == bookingRequestTs &&
        other.travelDate == travelDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uuid.hashCode ^
        orderUuid.hashCode ^
        fromSource.hashCode ^
        toDestination.hashCode ^
        flightNumber.hashCode ^
        airline.hashCode ^
        itineraryType.hashCode ^
        pnr.hashCode ^
        pnrStatus.hashCode ^
        pnrRetrieveResponse.hashCode ^
        pnrRetrieveErrorResponse.hashCode ^
        lastpnrRetrieveStatus.hashCode ^
        lastPnrRetrieveDateTime.hashCode ^
        passiveStatus.hashCode ^
        docIssuanceStatus.hashCode ^
        type.hashCode ^
        sector.hashCode ^
        corporate.hashCode ^
        status.hashCode ^
        segmentType.hashCode ^
        loginToken.hashCode ^
        bookingStatus.hashCode ^
        rescheduledItineraryRef.hashCode ^
        isGrouped.hashCode ^
        orderPassengerDetails.hashCode ^
        flightDetails.hashCode ^
        errorDetails.hashCode ^
        paymentReceived.hashCode ^
        cancellationType.hashCode ^
        rescheduleType.hashCode ^
        repriceStatus.hashCode ^
        creationTs.hashCode ^
        firstDeparture.hashCode ^
        modTs.hashCode ^
        ticketIssuance.hashCode ^
        ticketIssued.hashCode ^
        bookingTs.hashCode ^
        bookingRequestTs.hashCode ^
        travelDate.hashCode;
  }
}
