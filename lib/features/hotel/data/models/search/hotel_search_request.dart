import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/date_time_parser.dart';
import 'package:yellow_rose/core/utils/date_utils.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_room_request.dart';

class HotelListSearchRequest {
  final int pageNo;
  final int? pageSize;

  final String city;
  final String country;
  final double? priceMin;
  final double? priceMax;

  final double? starRating;
  final double? userRating;

  final String? mealBasis;
  final String? address;

  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int roomCount;
  final List<HotelRoomRequest> rooms;
  HotelListSearchRequest({
    required this.pageNo,
    this.pageSize,
    required this.city,
    required this.country,
    this.priceMin,
    this.priceMax,
    this.starRating,
    this.userRating,
    this.mealBasis,
    this.address,
    required this.checkInDate,
    required this.checkOutDate,
    required this.roomCount,
    required this.rooms,
  });

  HotelListSearchRequest copyWith({
    int? pageNo,
    int? pageSize,
    String? city,
    String? country,
    double? priceMin,
    double? priceMax,
    double? starRating,
    double? userRating,
    String? mealBasis,
    String? address,
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? roomCount,
    List<HotelRoomRequest>? rooms,
  }) {
    return HotelListSearchRequest(
      pageNo: pageNo ?? this.pageNo,
      pageSize: pageSize ?? this.pageSize,
      city: city ?? this.city,
      country: country ?? this.country,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      starRating: starRating ?? this.starRating,
      userRating: userRating ?? this.userRating,
      mealBasis: mealBasis ?? this.mealBasis,
      address: address ?? this.address,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      rooms: rooms ?? this.rooms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'pageNo': pageNo});
    if (pageSize != null) {
      result.addAll({'pageSize': pageSize});
    }
    result.addAll({'city': city});
    result.addAll({'country': country});
    if (priceMin != null) {
      result.addAll({'priceMin': priceMin});
    }
    if (priceMax != null) {
      result.addAll({'priceMax': priceMax});
    }
    if (starRating != null) {
      result.addAll({'starRating': starRating});
    }
    if (userRating != null) {
      result.addAll({'userRating': userRating});
    }
    if (mealBasis != null) {
      result.addAll({'mealBasis': mealBasis});
    }
    if (address != null) {
      result.addAll({'address': address});
    }
    result.addAll(
        {'checkInDate': CustomDateUtils.customApiDayFormat(checkInDate)});
    result.addAll(
        {'checkOutDate': CustomDateUtils.customApiDayFormat(checkOutDate)});
    result.addAll({'roomCount': roomCount});
    result.addAll({'rooms': rooms.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HotelListSearchRequest.fromMap(Map<String, dynamic> map) {
    return HotelListSearchRequest(
      pageNo: map['pageNo']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt(),
      city: map['city'] ?? '',
      country: map['country'] ?? '',
      priceMin: map['priceMin']?.toDouble(),
      priceMax: map['priceMax']?.toDouble(),
      starRating: map['starRating']?.toDouble(),
      userRating: map['userRating']?.toDouble(),
      mealBasis: map['mealBasis'],
      address: map['address'],
      checkInDate: DateTimeParser.parseFromMap(map, 'checkInDate'),
      checkOutDate: DateTimeParser.parseFromMap(map, 'checkOutDate'),
      roomCount: map['roomCount']?.toInt() ?? 0,
      rooms: List<HotelRoomRequest>.from(
          map['rooms']?.map((x) => HotelRoomRequest.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelListSearchRequest.fromJson(String source) =>
      HotelListSearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelListSearchRequest(pageNo: $pageNo, pageSize: $pageSize, city: $city, country: $country, priceMin: $priceMin, priceMax: $priceMax, starRating: $starRating, userRating: $userRating, mealBasis: $mealBasis, address: $address, checkInDate: $checkInDate, checkOutDate: $checkOutDate, roomCount: $roomCount, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelListSearchRequest &&
        other.pageNo == pageNo &&
        other.pageSize == pageSize &&
        other.city == city &&
        other.country == country &&
        other.priceMin == priceMin &&
        other.priceMax == priceMax &&
        other.starRating == starRating &&
        other.userRating == userRating &&
        other.mealBasis == mealBasis &&
        other.address == address &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.roomCount == roomCount &&
        listEquals(other.rooms, rooms);
  }

  @override
  int get hashCode {
    return pageNo.hashCode ^
        pageSize.hashCode ^
        city.hashCode ^
        country.hashCode ^
        priceMin.hashCode ^
        priceMax.hashCode ^
        starRating.hashCode ^
        userRating.hashCode ^
        mealBasis.hashCode ^
        address.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode ^
        roomCount.hashCode ^
        rooms.hashCode;
  }
}
