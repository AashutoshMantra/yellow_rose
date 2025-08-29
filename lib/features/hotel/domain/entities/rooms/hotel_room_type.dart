import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_amenities.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_rrom_cancellation.dart';

class HotelRoomType {
  final String? name;
  final String id;
  final double totalcost;
  final List<HotelRoomAmenities>? hotelRoomAmenities;
  final List<HotelRoomPenalty>? hotelRoomPenalty;
  HotelRoomType({
    this.name,
    required this.id,
    required this.totalcost,
    this.hotelRoomAmenities,
    this.hotelRoomPenalty,
  });

  HotelRoomType copyWith({
    String? name,
    String? id,
    double? totalcost,
    List<HotelRoomAmenities>? hotelRoomAmenities,
    List<HotelRoomPenalty>? hotelRoomPenalty,
  }) {
    return HotelRoomType(
      name: name ?? this.name,
      id: id ?? this.id,
      totalcost: totalcost ?? this.totalcost,
      hotelRoomAmenities: hotelRoomAmenities ?? this.hotelRoomAmenities,
      hotelRoomPenalty: hotelRoomPenalty ?? this.hotelRoomPenalty,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    result.addAll({'id': id});
    result.addAll({'totalcost': totalcost});
    if (hotelRoomAmenities != null) {
      result.addAll({
        'hotelRoomAmenities': hotelRoomAmenities!.map((x) => x.toMap()).toList()
      });
    }
    if (hotelRoomPenalty != null) {
      result.addAll({
        'hotelRoomPenalty': hotelRoomPenalty!.map((x) => x.toMap()).toList()
      });
    }

    return result;
  }

  factory HotelRoomType.fromMap(Map<String, dynamic> map) {
    return HotelRoomType(
      name: map['name'],
      id: map['id'] ?? '',
      totalcost: map['totalcost']?.toDouble() ?? 0.0,
      hotelRoomAmenities: map['hotelRoomAmenities'] != null
          ? List<HotelRoomAmenities>.from(map['hotelRoomAmenities']
              ?.map((x) => HotelRoomAmenities.fromMap(x)))
          : null,
      hotelRoomPenalty: map['hotelRoomPenalty'] != null
          ? List<HotelRoomPenalty>.from(
              map['hotelRoomPenalty']?.map((x) => HotelRoomPenalty.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRoomType.fromJson(String source) =>
      HotelRoomType.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelRoomType(name: $name, id: $id, totalcost: $totalcost, hotelRoomAmenities: $hotelRoomAmenities, hotelRoomPenalty: $hotelRoomPenalty)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelRoomType &&
        other.name == name &&
        other.id == id &&
        other.totalcost == totalcost &&
        listEquals(other.hotelRoomAmenities, hotelRoomAmenities) &&
        listEquals(other.hotelRoomPenalty, hotelRoomPenalty);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        totalcost.hashCode ^
        hotelRoomAmenities.hashCode ^
        hotelRoomPenalty.hashCode;
  }
}
