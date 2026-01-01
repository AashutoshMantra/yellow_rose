import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/product_type.dart';
import 'package:yellow_rose/features/trip/data/models/trip_response.dart';

class TripAirItem {
  final String? id;

  final String? fromAirport;

  final String? toAirport;

  final String? status;

  final DateTime? requestedDate;

  final String? travelType;

  final ProductTypeEnum? type;

  final TripResponse? trip;

  final DateTime? bookingTs;

  final String? cartId;

  final int? failedAttempts;

  final double? itineraryCost;

  final String? flightNumber;

  final DateTime? firstDeparture;
  final String? sector;

  final String? checkInDate;

  final String? hotelName;

  final String? roomType;
  TripAirItem({
    this.id,
    this.fromAirport,
    this.toAirport,
    this.status,
    this.requestedDate,
    this.travelType,
    this.type,
    this.trip,
    this.bookingTs,
    this.cartId,
    this.failedAttempts,
    this.itineraryCost,
    this.flightNumber,
    this.firstDeparture,
    this.sector,
    this.checkInDate,
    this.hotelName,
    this.roomType,
  });

  TripAirItem copyWith({
    String? id,
    String? fromAirport,
    String? toAirport,
    String? status,
    DateTime? requestedDate,
    String? travelType,
    ProductTypeEnum? type,
    TripResponse? trip,
    DateTime? bookingTs,
    String? cartId,
    int? failedAttempts,
    double? itineraryCost,
    String? flightNumber,
    DateTime? firstDeparture,
    String? sector,
    String? checkInDate,
    String? hotelName,
    String? roomType,
  }) {
    return TripAirItem(
      id: id ?? this.id,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      status: status ?? this.status,
      requestedDate: requestedDate ?? this.requestedDate,
      travelType: travelType ?? this.travelType,
      type: type ?? this.type,
      trip: trip ?? this.trip,
      bookingTs: bookingTs ?? this.bookingTs,
      cartId: cartId ?? this.cartId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      itineraryCost: itineraryCost ?? this.itineraryCost,
      flightNumber: flightNumber ?? this.flightNumber,
      firstDeparture: firstDeparture ?? this.firstDeparture,
      sector: sector ?? this.sector,
      checkInDate: checkInDate ?? this.checkInDate,
      hotelName: hotelName ?? this.hotelName,
      roomType: roomType ?? this.roomType,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (fromAirport != null) {
      result.addAll({'fromAirport': fromAirport});
    }
    if (toAirport != null) {
      result.addAll({'toAirport': toAirport});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    result.addAll({'requestedDate': requestedDate?.toString()});
    if (travelType != null) {
      result.addAll({'travelType': travelType});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (trip != null) {
      result.addAll({'trip': trip!.toMap()});
    }
    result.addAll({'bookingTs': bookingTs?.toString()});
    if (cartId != null) {
      result.addAll({'cartId': cartId});
    }
    result.addAll({'failedAttempts': failedAttempts});
    result.addAll({'itineraryCost': itineraryCost});
    if (flightNumber != null) {
      result.addAll({'flightNumber': flightNumber});
    }
    result.addAll({'firstDeparture': firstDeparture?.toString()});
    if (sector != null) {
      result.addAll({'sector': sector});
    }
    if (checkInDate != null) {
      result.addAll({'checkInDate': checkInDate});
    }
    if (hotelName != null) {
      result.addAll({'hotelName': hotelName});
    }
    if (roomType != null) {
      result.addAll({'roomType': roomType});
    }

    return result;
  }

  factory TripAirItem.fromMap(Map<String, dynamic> map) {
    return TripAirItem(
      id: map['id'],
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      status: map['status'],
      requestedDate: DateTime.tryParse(map['requestedDate'] ?? ''),
      travelType: map['travelType'],
      type: (map['type'] as String?)?.toEnum(ProductTypeEnum.values),
      trip: map['trip'] != null ? TripResponse.fromMap(map['trip']) : null,
      bookingTs: DateTime.tryParse(map['bookingTs'] ?? ''),
      cartId: map['cartId'],
      failedAttempts: map['failedAttempts']?.toInt() ?? 0,
      itineraryCost: map['itineraryCost']?.toDouble() ?? 0.0,
      flightNumber: map['flightNumber'],
      firstDeparture: DateTime.tryParse(map['firstDeparture'] ?? ''),
      sector: map['sector'],
      checkInDate: map['checkInDate'],
      hotelName: map['hotelName'],
      roomType: map['roomType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TripAirItem.fromJson(String source) =>
      TripAirItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TripAirItem(id: $id, fromAirport: $fromAirport, toAirport: $toAirport, status: $status, requestedDate: $requestedDate, travelType: $travelType, type: $type, trip: $trip, bookingTs: $bookingTs, cartId: $cartId, failedAttempts: $failedAttempts, itineraryCost: $itineraryCost, flightNumber: $flightNumber, firstDeparture: $firstDeparture, sector: $sector, checkInDate: $checkInDate, hotelName: $hotelName, roomType: $roomType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripAirItem &&
        other.id == id &&
        other.fromAirport == fromAirport &&
        other.toAirport == toAirport &&
        other.status == status &&
        other.requestedDate == requestedDate &&
        other.travelType == travelType &&
        other.type == type &&
        other.trip == trip &&
        other.bookingTs == bookingTs &&
        other.cartId == cartId &&
        other.failedAttempts == failedAttempts &&
        other.itineraryCost == itineraryCost &&
        other.flightNumber == flightNumber &&
        other.firstDeparture == firstDeparture &&
        other.sector == sector &&
        other.checkInDate == checkInDate &&
        other.hotelName == hotelName &&
        other.roomType == roomType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fromAirport.hashCode ^
        toAirport.hashCode ^
        status.hashCode ^
        requestedDate.hashCode ^
        travelType.hashCode ^
        type.hashCode ^
        trip.hashCode ^
        bookingTs.hashCode ^
        cartId.hashCode ^
        failedAttempts.hashCode ^
        itineraryCost.hashCode ^
        flightNumber.hashCode ^
        firstDeparture.hashCode ^
        sector.hashCode ^
        checkInDate.hashCode ^
        hotelName.hashCode ^
        roomType.hashCode;
  }
}
