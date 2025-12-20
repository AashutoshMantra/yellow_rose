import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/features/bus/data/models/bus_order_passenger_detail.dart';
import 'package:yellow_rose/features/bus/data/models/order/user_bus_booking_request.dart';
import 'package:yellow_rose/features/bus/data/models/search/red_bus_comercial.dart';
import 'package:yellow_rose/features/bus/domain/enums/bus_booking_status.dart';
import 'package:yellow_rose/features/flight/data/models/booking/order/customer_payment.dart';

class BusOrderItinerary {
  final int? id;

  final String? uuid;

  final String? orderUuid;

  final String? fromSource;

  final String? toDestination;

  final String? busNumber;

  final String? itineraryType;

  final String? bookingId;

  final BusBookingStatus? bookingStatus;

  final String? type;

  final String? sector;

  final String? corporate;

  final String? status;

  // final BookingOrder orderId;

  final String? requestId;

  final List<BusOrderPassengerDetails>? busOrderPassengerDetails;

  final UserBusBookingRequest? busDetails;

  final Map<String, dynamic>? errorDetails;

  final CustomerPayment customerPayment;

  final RedbusCommercial? commissionData;

  final DateTime? creationTs;

  final DateTime? firstDeparture;

  final DateTime? modTs;

  final bool? ticketIssued;

  final DateTime? bookingTs;

  final DateTime? bookingRequestTs;

  final String? travelDate;
  BusOrderItinerary({
    this.id,
    this.uuid,
    this.orderUuid,
    this.fromSource,
    this.toDestination,
    this.busNumber,
    this.itineraryType,
    this.bookingId,
    this.bookingStatus,
    this.type,
    this.sector,
    this.corporate,
    this.status,
    this.requestId,
    this.busOrderPassengerDetails,
    this.busDetails,
    this.errorDetails,
    required this.customerPayment,
    this.commissionData,
    this.creationTs,
    this.firstDeparture,
    this.modTs,
    this.ticketIssued,
    this.bookingTs,
    this.bookingRequestTs,
    this.travelDate,
  });

  BusOrderItinerary copyWith({
    int? id,
    String? uuid,
    String? orderUuid,
    String? fromSource,
    String? toDestination,
    String? busNumber,
    String? itineraryType,
    String? bookingId,
    BusBookingStatus? bookingStatus,
    String? type,
    String? sector,
    String? corporate,
    String? status,
    String? requestId,
    List<BusOrderPassengerDetails>? busOrderPassengerDetails,
    UserBusBookingRequest? busDetails,
    Map<String, dynamic>? errorDetails,
    CustomerPayment? customerPayment,
    RedbusCommercial? commissionData,
    DateTime? creationTs,
    DateTime? firstDeparture,
    DateTime? modTs,
    bool? ticketIssued,
    DateTime? bookingTs,
    DateTime? bookingRequestTs,
    String? travelDate,
  }) {
    return BusOrderItinerary(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      orderUuid: orderUuid ?? this.orderUuid,
      fromSource: fromSource ?? this.fromSource,
      toDestination: toDestination ?? this.toDestination,
      busNumber: busNumber ?? this.busNumber,
      itineraryType: itineraryType ?? this.itineraryType,
      bookingId: bookingId ?? this.bookingId,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      type: type ?? this.type,
      sector: sector ?? this.sector,
      corporate: corporate ?? this.corporate,
      status: status ?? this.status,
      requestId: requestId ?? this.requestId,
      busOrderPassengerDetails:
          busOrderPassengerDetails ?? this.busOrderPassengerDetails,
      busDetails: busDetails ?? this.busDetails,
      errorDetails: errorDetails ?? this.errorDetails,
      customerPayment: customerPayment ?? this.customerPayment,
      commissionData: commissionData ?? this.commissionData,
      creationTs: creationTs ?? this.creationTs,
      firstDeparture: firstDeparture ?? this.firstDeparture,
      modTs: modTs ?? this.modTs,
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
    if (busNumber != null) {
      result.addAll({'busNumber': busNumber});
    }
    if (itineraryType != null) {
      result.addAll({'itineraryType': itineraryType});
    }
    if (bookingId != null) {
      result.addAll({'bookingId': bookingId});
    }
    if (bookingStatus != null) {
      result.addAll({'bookingStatus': bookingStatus!.shortCode});
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
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (busOrderPassengerDetails != null) {
      result.addAll({
        'busOrderPassengerDetails':
            busOrderPassengerDetails!.map((x) => x.toMap()).toList()
      });
    }
    if (busDetails != null) {
      result.addAll({'busDetails': busDetails!.toMap()});
    }
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails});
    }
    result.addAll({'customerPayment': customerPayment.toMap()});
    if (commissionData != null) {
      result.addAll({'commissionData': commissionData!.toMap()});
    }
    if (creationTs != null) {
      result.addAll({
        'creationTs':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(creationTs!)
      });
    }
    if (firstDeparture != null) {
      result.addAll({
        'firstDeparture':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(firstDeparture!)
      });
    }
    if (modTs != null) {
      result.addAll(
          {'modTs': CustomDateUtils.dateTimeInIsoFormatWithoutZone(modTs!)});
    }
    if (ticketIssued != null) {
      result.addAll({'ticketIssued': ticketIssued});
    }
    if (bookingTs != null) {
      result.addAll({
        'bookingTs': CustomDateUtils.dateTimeInIsoFormatWithoutZone(bookingTs!)
      });
    }
    if (bookingRequestTs != null) {
      result.addAll({
        'bookingRequestTs':
            CustomDateUtils.dateTimeInIsoFormatWithoutZone(bookingRequestTs!)
      });
    }
    if (travelDate != null) {
      result.addAll({'travelDate': travelDate});
    }

    return result;
  }

  factory BusOrderItinerary.fromMap(Map<String, dynamic> map) {
    return BusOrderItinerary(
      id: map['id']?.toInt(),
      uuid: map['uuid'],
      orderUuid: map['orderUuid'],
      fromSource: map['fromSource'],
      toDestination: map['toDestination'],
      busNumber: map['busNumber'],
      itineraryType: map['itineraryType'],
      bookingId: map['bookingId'],
      bookingStatus: BusBookingStatus.fromShortCode(map['bookingStatus']),
      type: map['type'],
      sector: map['sector'],
      corporate: map['corporate'],
      status: map['status'],
      requestId: map['requestId'],
      busOrderPassengerDetails: map['busOrderPassengerDetails'] != null
          ? List<BusOrderPassengerDetails>.from(map['busOrderPassengerDetails']
              ?.map((x) => BusOrderPassengerDetails.fromMap(x)))
          : null,
      busDetails: map['busDetails'] != null
          ? UserBusBookingRequest.fromMap(map['busDetails'])
          : null,
      errorDetails: map['errorDetails'] != null
          ? Map<String, dynamic>.from(map['errorDetails'])
          : null,
      customerPayment: CustomerPayment.fromMap(map['customerPayment']),
      commissionData: map['commissionData'] != null
          ? RedbusCommercial.fromMap(map['commissionData'])
          : null,
      creationTs: map['creationTs'] != null
          ? DateTime.tryParse(map['creationTs'])
          : null,
      firstDeparture: map['firstDeparture'] != null
          ? DateTime.tryParse(map['firstDeparture'])
          : null,
      modTs: map['modTs'] != null ? DateTime.tryParse(map['modTs']) : null,
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

  factory BusOrderItinerary.fromJson(String source) =>
      BusOrderItinerary.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusOrderItinerary(id: $id, uuid: $uuid, orderUuid: $orderUuid, fromSource: $fromSource, toDestination: $toDestination, busNumber: $busNumber, itineraryType: $itineraryType, bookingId: $bookingId, bookingStatus: $bookingStatus, type: $type, sector: $sector, corporate: $corporate, status: $status, requestId: $requestId, busOrderPassengerDetails: $busOrderPassengerDetails, busDetails: $busDetails, errorDetails: $errorDetails, customerPayment: $customerPayment, commissionData: $commissionData, creationTs: $creationTs, firstDeparture: $firstDeparture, modTs: $modTs, ticketIssued: $ticketIssued, bookingTs: $bookingTs, bookingRequestTs: $bookingRequestTs, travelDate: $travelDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusOrderItinerary &&
        other.id == id &&
        other.uuid == uuid &&
        other.orderUuid == orderUuid &&
        other.fromSource == fromSource &&
        other.toDestination == toDestination &&
        other.busNumber == busNumber &&
        other.itineraryType == itineraryType &&
        other.bookingId == bookingId &&
        other.bookingStatus == bookingStatus &&
        other.type == type &&
        other.sector == sector &&
        other.corporate == corporate &&
        other.status == status &&
        other.requestId == requestId &&
        listEquals(other.busOrderPassengerDetails, busOrderPassengerDetails) &&
        other.busDetails == busDetails &&
        mapEquals(other.errorDetails, errorDetails) &&
        other.customerPayment == customerPayment &&
        other.commissionData == commissionData &&
        other.creationTs == creationTs &&
        other.firstDeparture == firstDeparture &&
        other.modTs == modTs &&
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
        busNumber.hashCode ^
        itineraryType.hashCode ^
        bookingId.hashCode ^
        bookingStatus.hashCode ^
        type.hashCode ^
        sector.hashCode ^
        corporate.hashCode ^
        status.hashCode ^
        requestId.hashCode ^
        busOrderPassengerDetails.hashCode ^
        busDetails.hashCode ^
        errorDetails.hashCode ^
        customerPayment.hashCode ^
        commissionData.hashCode ^
        creationTs.hashCode ^
        firstDeparture.hashCode ^
        modTs.hashCode ^
        ticketIssued.hashCode ^
        bookingTs.hashCode ^
        bookingRequestTs.hashCode ^
        travelDate.hashCode;
  }
}
