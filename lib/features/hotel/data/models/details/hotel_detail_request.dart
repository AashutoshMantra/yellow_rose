import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';

import 'package:yellow_rose/features/hotel/data/models/search/hotel_room_request.dart';

class HotelDetailRequest {
  final int? hotelId;
  final String? mmtHotelId;
  final int? agodaHotelId;
  final String? hummingbirdHotelId;
  final String? hummingbirdHotelCode;
  final String? country;
  final String? requestId;
  final String? userBookingContext;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? roomCount;

  final List<HotelRoomRequest>? rooms;

  HotelDetailRequest(
      {this.hotelId,
      this.mmtHotelId,
      this.agodaHotelId,
      this.hummingbirdHotelId,
      this.hummingbirdHotelCode,
      this.country,
      this.checkInDate,
      this.checkOutDate,
      this.roomCount,
      this.rooms,
      this.requestId,
      this.userBookingContext});

  HotelDetailRequest copyWith({
    int? hotelId,
    String? mmtHotelId,
    int? agodaHotelId,
    String? hummingbirdHotelId,
    String? hummingbirdHotelCode,
    String? country,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? roomCount,
    String? requestId,
    String? userBookingContext,
    List<HotelRoomRequest>? rooms,
  }) {
    return HotelDetailRequest(
      hotelId: hotelId ?? this.hotelId,
      mmtHotelId: mmtHotelId ?? this.mmtHotelId,
      agodaHotelId: agodaHotelId ?? this.agodaHotelId,
      hummingbirdHotelId: hummingbirdHotelId ?? this.hummingbirdHotelId,
      hummingbirdHotelCode: hummingbirdHotelCode ?? this.hummingbirdHotelCode,
      country: country ?? this.country,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      rooms: rooms ?? this.rooms,
      requestId: requestId ?? this.requestId,
      userBookingContext: userBookingContext ?? this.userBookingContext,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (hotelId != null) {
      result.addAll({'hotelId': hotelId});
    }
    if (mmtHotelId != null) {
      result.addAll({'mmtHotelId': mmtHotelId});
    }
    if (agodaHotelId != null) {
      result.addAll({'agodaHotelId': agodaHotelId});
    }
    if (hummingbirdHotelId != null) {
      result.addAll({'hummingbirdHotelId': hummingbirdHotelId});
    }
    if (hummingbirdHotelCode != null) {
      result.addAll({'hummingbirdHotelCode': hummingbirdHotelCode});
    }
    if (country != null) {
      result.addAll({'country': country});
    }
    if (checkInDate != null) {
      result.addAll(
          {'checkInDate': CustomDateUtils.customApiDayFormat(checkInDate!)});
    }
    if (checkOutDate != null) {
      result.addAll(
          {'checkOutDate': CustomDateUtils.customApiDayFormat(checkOutDate!)});
    }

    if (roomCount != null) {
      result.addAll({'roomCount': roomCount});
    }
    if (rooms != null) {
      result.addAll({'rooms': rooms!.map((x) => x.toMap()).toList()});
    }
    if (requestId != null) {
      result.addAll({'requestId': requestId});
    }
    if (userBookingContext != null) {
      result.addAll({'userBookingContext': userBookingContext});
    }

    return result;
  }

  factory HotelDetailRequest.fromMap(Map<String, dynamic> map) {
    return HotelDetailRequest(
      hotelId: map['hotelId']?.toInt(),
      mmtHotelId: map['mmtHotelId'],
      agodaHotelId: map['agodaHotelId']?.toInt(),
      hummingbirdHotelId: map['hummingbirdHotelId']?.toString(),
      hummingbirdHotelCode: map['hummingbirdHotelCode']?.toString(),
      country: map['country'],
      checkInDate: map['checkInDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkInDate'])
          : null,
      checkOutDate: map['checkOutDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkOutDate'])
          : null,
      roomCount: map['roomCount']?.toInt(),
      rooms: map['rooms'] != null
          ? List<HotelRoomRequest>.from(
              map['rooms']?.map((x) => HotelRoomRequest.fromMap(x)))
          : null,
      userBookingContext: map['userBookingContext'],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailRequest.fromJson(String source) =>
      HotelDetailRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailRequest(hotelId: $hotelId, mmtHotelId: $mmtHotelId, agodaHotelId: $agodaHotelId, hummingbirdHotelId: $hummingbirdHotelId, hummingbirdHotelCode: $hummingbirdHotelCode, country: $country, checkInDate: $checkInDate, checkOutDate: $checkOutDate, roomCount: $roomCount, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailRequest &&
        other.hotelId == hotelId &&
        other.mmtHotelId == mmtHotelId &&
        other.agodaHotelId == agodaHotelId &&
        other.hummingbirdHotelId == hummingbirdHotelId &&
        other.hummingbirdHotelCode == hummingbirdHotelCode &&
        other.country == country &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.roomCount == roomCount &&
        other.userBookingContext == userBookingContext &&
        listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return hotelId.hashCode ^
        mmtHotelId.hashCode ^
        agodaHotelId.hashCode ^
        hummingbirdHotelId.hashCode ^
        hummingbirdHotelCode.hashCode ^
        country.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode ^
        roomCount.hashCode ^
        userBookingContext.hashCode ^
        rooms.hashCode;
  }
}
