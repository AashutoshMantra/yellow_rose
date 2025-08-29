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
  final String? country;
  final String? requestId;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? roomCount;

  final List<HotelRoomRequest>? rooms;

  HotelDetailRequest(
      {this.hotelId,
      this.mmtHotelId,
      this.agodaHotelId,
      this.country,
      this.checkInDate,
      this.checkOutDate,
      this.roomCount,
      this.rooms,
      this.requestId});

  HotelDetailRequest copyWith({
    int? hotelId,
    String? mmtHotelId,
    int? agodaHotelId,
    String? country,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? roomCount,
    String? requestId,
    List<HotelRoomRequest>? rooms,
  }) {
    return HotelDetailRequest(
      hotelId: hotelId ?? this.hotelId,
      mmtHotelId: mmtHotelId ?? this.mmtHotelId,
      agodaHotelId: agodaHotelId ?? this.agodaHotelId,
      country: country ?? this.country,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      rooms: rooms ?? this.rooms,
      requestId: requestId ?? this.requestId,
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

    return result;
  }

  factory HotelDetailRequest.fromMap(Map<String, dynamic> map) {
    return HotelDetailRequest(
      hotelId: map['hotelId']?.toInt(),
      mmtHotelId: map['mmtHotelId'],
      agodaHotelId: map['agodaHotelId']?.toInt(),
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
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailRequest.fromJson(String source) =>
      HotelDetailRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailRequest(hotelId: $hotelId, mmtHotelId: $mmtHotelId, agodaHotelId: $agodaHotelId, country: $country, checkInDate: $checkInDate, checkOutDate: $checkOutDate, roomCount: $roomCount, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailRequest &&
        other.hotelId == hotelId &&
        other.mmtHotelId == mmtHotelId &&
        other.agodaHotelId == agodaHotelId &&
        other.country == country &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.roomCount == roomCount &&
        listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return hotelId.hashCode ^
        mmtHotelId.hashCode ^
        agodaHotelId.hashCode ^
        country.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode ^
        roomCount.hashCode ^
        rooms.hashCode;
  }
}
