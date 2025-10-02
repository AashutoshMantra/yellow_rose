import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/hotel/data/models/places/places.dart';

class HotelSearch {
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final int? roomCount;
  final int? adultCount;
  final List<int>? childAges;
  final bool isInternational;
  final PlaceEntity? place;
  final String requestId;
  HotelSearch({
    this.checkInDate,
    this.checkOutDate,
    this.roomCount,
    this.adultCount,
    this.childAges,
    this.place,
  })  : isInternational =
            (place == null || place.country?.equalsIgnoreCase("IN") == true)
                ? false
                : true,
        requestId = const Uuid().v4();

  HotelSearch copyWith({
    DateTime? checkInDate,
    DateTime? checkOutDate,
    int? roomCount,
    int? adultCount,
    List<int>? childAges,
    String? country,
    PlaceEntity? place,
  }) {
    return HotelSearch(
      checkInDate: checkInDate ?? this.checkInDate,
      checkOutDate: checkOutDate ?? this.checkOutDate,
      roomCount: roomCount ?? this.roomCount,
      adultCount: adultCount ?? this.adultCount,
      childAges: childAges ?? this.childAges,
      place: place ?? this.place,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (checkInDate != null) {
      result.addAll({'checkInDate': checkInDate!.millisecondsSinceEpoch});
    }
    if (checkOutDate != null) {
      result.addAll({'checkOutDate': checkOutDate!.millisecondsSinceEpoch});
    }
    if (roomCount != null) {
      result.addAll({'roomCount': roomCount});
    }
    if (adultCount != null) {
      result.addAll({'adultCount': adultCount});
    }
    if (childAges != null) {
      result.addAll({'childAges': childAges});
    }
    result.addAll({'isInternational': isInternational});

    if (place != null) {
      result.addAll({'place': place!.toMap()});
    }

    return result;
  }

  factory HotelSearch.fromMap(Map<String, dynamic> map) {
    return HotelSearch(
      checkInDate: map['checkInDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkInDate'])
          : null,
      checkOutDate: map['checkOutDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkOutDate'])
          : null,
      roomCount: map['roomCount']?.toInt(),
      adultCount: map['adultCount']?.toInt(),
      childAges: List<int>.from(map['childAges']),
      place: map['place'] != null ? PlaceEntity.fromMap(map['place']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelSearch.fromJson(String source) =>
      HotelSearch.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelSearch &&
        other.checkInDate == checkInDate &&
        other.checkOutDate == checkOutDate &&
        other.roomCount == roomCount &&
        other.adultCount == adultCount &&
        listEquals(other.childAges, childAges) &&
        other.isInternational == isInternational &&
        other.place == place;
  }

  @override
  int get hashCode {
    return checkInDate.hashCode ^
        checkOutDate.hashCode ^
        roomCount.hashCode ^
        adultCount.hashCode ^
        Object.hashAll(childAges ?? []) ^
        isInternational.hashCode ^
        (place?.hashCode ?? 0);
  }
}
