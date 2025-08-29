import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/search/hotel_search_response.dart';

class HotelResponseList {
  final List<HotelSearchResponse> hotels;

  HotelResponseList({
    required this.hotels,
  });

  HotelResponseList copyWith({
    List<HotelSearchResponse>? hotels,
  }) {
    return HotelResponseList(
      hotels: hotels ?? this.hotels,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'hotels': hotels.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HotelResponseList.fromMap(Map<String, dynamic> map) {
    return HotelResponseList(
      hotels: List<HotelSearchResponse>.from(
          map['hotels']?.map((x) => HotelSearchResponse.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelResponseList.fromJson(String source) =>
      HotelResponseList.fromMap(json.decode(source));

  @override
  String toString() => 'HotelResponseList(hotels: $hotels)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelResponseList && listEquals(other.hotels, hotels);
  }

  @override
  int get hashCode => hotels.hashCode;
}
