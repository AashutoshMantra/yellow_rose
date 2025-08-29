import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/hotel/data/models/order/hotel-source.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_amenities.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_room_type.dart';
import 'package:yellow_rose/features/hotel/domain/entities/rooms/hotel_rrom_cancellation.dart';

class HotelRoom {
  final String? name;
  final String id;
  final List<String>? images;
  final String? bedType;
  final String? bedSize;
  final HotelSourceEnum hotelSourceEnum;
  final List<HotelRoomType> hotelRooms;
  HotelRoom({
    this.name,
    required this.id,
    this.images,
    this.bedType,
    this.bedSize,
    required this.hotelSourceEnum,
    required this.hotelRooms,
  });

  HotelRoom copyWith({
    String? name,
    String? id,
    List<String>? images,
    String? bedType,
    String? bedSize,
    HotelSourceEnum? hotelSourceEnum,
    List<HotelRoomType>? hotelRooms,
  }) {
    return HotelRoom(
      name: name ?? this.name,
      id: id ?? this.id,
      images: images ?? this.images,
      bedType: bedType ?? this.bedType,
      bedSize: bedSize ?? this.bedSize,
      hotelSourceEnum: hotelSourceEnum ?? this.hotelSourceEnum,
      hotelRooms: hotelRooms ?? this.hotelRooms,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    result.addAll({'id': id});
    if (images != null) {
      result.addAll({'images': images});
    }
    if (bedType != null) {
      result.addAll({'bedType': bedType});
    }
    if (bedSize != null) {
      result.addAll({'bedSize': bedSize});
    }
    result.addAll({'hotelSourceEnum': hotelSourceEnum.name});
    result.addAll({'hotelRooms': hotelRooms.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HotelRoom.fromMap(Map<String, dynamic> map) {
    return HotelRoom(
      name: map['name'],
      id: map['id'] ?? '',
      images: List<String>.from(map['images']),
      bedType: map['bedType'],
      bedSize: map['bedSize'],
      hotelSourceEnum:
          stringToEnum(map['hotelSourceEnum']!, HotelSourceEnum.values)!,
      hotelRooms: List<HotelRoomType>.from(
          map['hotelRooms']?.map((x) => HotelRoomType.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelRoom.fromJson(String source) =>
      HotelRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelRoom(name: $name, id: $id, images: $images, bedType: $bedType, bedSize: $bedSize, hotelSourceEnum: $hotelSourceEnum, hotelRooms: $hotelRooms)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelRoom &&
        other.name == name &&
        other.id == id &&
        listEquals(other.images, images) &&
        other.bedType == bedType &&
        other.bedSize == bedSize &&
        other.hotelSourceEnum == hotelSourceEnum &&
        listEquals(other.hotelRooms, hotelRooms);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        id.hashCode ^
        images.hashCode ^
        bedType.hashCode ^
        bedSize.hashCode ^
        hotelSourceEnum.hashCode ^
        hotelRooms.hashCode;
  }
}
