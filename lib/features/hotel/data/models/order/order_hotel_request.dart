import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/search/hotel_room_request.dart';
import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_request.dart';

class OrderHotelSearchRequest {
  final String? city;
  final String? checkInDate;
  final String? checkOutDate;
  final int? roomCount;
  final int? adultCount;
  final int? childCount;
  final int? adults;
  final List<int>? childrenAges;
  final List<HotelRoomRequest>? rooms;
  final bool isInternational;
  final bool isDomestic;
  final String? source;
  final String? supplier;
  final int? pageNo;
  final int? pageSize;
  final String? country;
  OrderHotelSearchRequest({
    this.city,
    this.checkInDate,
    this.checkOutDate,
    this.roomCount,
    this.adultCount,
    this.childCount,
    this.adults,
    this.childrenAges,
    this.rooms,
    this.isInternational = false,
    this.isDomestic = false,
    this.source,
    this.supplier,
    this.pageNo,
    this.pageSize,
    this.country,
  });

  OrderHotelSearchRequest copyWith({
    String? city,
    String? checkInDate,
    String? checkOutDate,
    int? roomCount,
    int? adultCount,
    int? childCount,
    int? adults,
    List<int>? childrenAges,
    List<HotelRoomRequest>? rooms,
    bool? isInternational,
    bool? isDomestic,
    String? source,
    String? supplier,
    int? pageNo,
    int? pageSize,
    String? country,
  }) {
    return OrderHotelSearchRequest(
      city: city ?? this.city,
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      adultCount: adultCount ?? this.adultCount,
      childCount: childCount ?? this.childCount,
      adults: adults ?? this.adults,
      childrenAges: childrenAges ?? this.childrenAges,
      rooms: rooms ?? this.rooms,
      isInternational: isInternational ?? this.isInternational,
      isDomestic: isDomestic ?? this.isDomestic,
      source: source ?? this.source,
      supplier: supplier ?? this.supplier,
      pageNo: pageNo ?? this.pageNo,
      pageSize: pageSize ?? this.pageSize,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (city != null) {
      result.addAll({'city': city});
    }
    if (checkInDate != null) {
      result.addAll({'checkInDate': checkInDate});
    }
    if (checkOutDate != null) {
      result.addAll({'checkOutDate': checkOutDate});
    }
    if (roomCount != null) {
      result.addAll({'roomCount': roomCount});
    }
    if (adultCount != null) {
      result.addAll({'adultCount': adultCount});
    }
    if (childCount != null) {
      result.addAll({'childCount': childCount});
    }
    result.addAll({'adults': adults});
    if (childrenAges != null) {
      result.addAll({'childrenAges': childrenAges});
    }
    if (rooms != null) {
      result.addAll({'rooms': rooms!.map((x) => x.toMap()).toList()});
    }
    result.addAll({'isInternational': isInternational});
    result.addAll({'isDomestic': isDomestic});
    if (source != null) {
      result.addAll({'source': source});
    }
    if (supplier != null) {
      result.addAll({'supplier': supplier});
    }
    if (pageNo != null) {
      result.addAll({'pageNo': pageNo});
    }
    if (pageSize != null) {
      result.addAll({'pageSize': pageSize});
    }
    result.addAll({'country': country});

    return result;
  }

  factory OrderHotelSearchRequest.fromMap(Map<String, dynamic> map) {
    return OrderHotelSearchRequest(
      city: map['city'],
      checkInDate: map['checkInDate'],
      checkOutDate: map['checkOutDate'],
      roomCount: map['roomCount']?.toInt(),
      adultCount: map['adultCount']?.toInt(),
      childCount: map['childCount']?.toInt(),
      adults: map['adults']?.toInt() ?? 0,
      childrenAges: List<int>.from(map['childrenAges']),
      rooms: map['rooms'] != null
          ? List<HotelRoomRequest>.from(
              map['rooms']?.map((x) => HotelRoomRequest.fromMap(x)))
          : null,
      isInternational: map['isInternational'] ?? false,
      isDomestic: map['isDomestic'] ?? false,
      source: map['source'],
      supplier: map['supplier'],
      pageNo: map['pageNo']?.toInt(),
      pageSize: map['pageSize']?.toInt(),
      country: map['country'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderHotelSearchRequest.fromJson(String source) =>
      OrderHotelSearchRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderHotelRequest(city: $city, checkInDate: $checkInDate, checkOutDate: $checkOutDate, roomCount: $roomCount, adultCount: $adultCount, childCount: $childCount, adults: $adults, childrenAges: $childrenAges, rooms: $rooms, isInternational: $isInternational, isDomestic: $isDomestic, source: $source, supplier: $supplier, pageNo: $pageNo, pageSize: $pageSize, country: $country)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderHotelSearchRequest &&
        other.city == city &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.roomCount == roomCount &&
        other.adultCount == adultCount &&
        other.childCount == childCount &&
        other.adults == adults &&
        listEquals(other.childrenAges, childrenAges) &&
        listEquals(other.rooms, rooms) &&
        other.isInternational == isInternational &&
        other.isDomestic == isDomestic &&
        other.source == source &&
        other.supplier == supplier &&
        other.pageNo == pageNo &&
        other.pageSize == pageSize &&
        other.country == country;
  }

  @override
  int get hashCode {
    return city.hashCode ^
        checkInDate.hashCode ^
        checkOutDate.hashCode ^
        roomCount.hashCode ^
        adultCount.hashCode ^
        childCount.hashCode ^
        adults.hashCode ^
        childrenAges.hashCode ^
        rooms.hashCode ^
        isInternational.hashCode ^
        isDomestic.hashCode ^
        source.hashCode ^
        supplier.hashCode ^
        pageNo.hashCode ^
        pageSize.hashCode ^
        country.hashCode;
  }
}
