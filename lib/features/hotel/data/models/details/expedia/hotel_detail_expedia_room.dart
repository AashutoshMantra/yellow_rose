import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/hotel_detail_expedia_rate_plan.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/content_response_room.dart';
import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/expedia_room_images.dart';

class HotelDetailExpediaRoom {
  final String? id;
  final String? roomName;
  final List<HotelDetailExpediaRatePlan>? rates;
  final ExpediaHotelContentResponseRoom? roomMeta;
  final List<ExpediRoomImageModel> images;
  HotelDetailExpediaRoom({
    this.id,
    this.roomName,
    this.rates,
    this.roomMeta,
    required this.images,
  });

  HotelDetailExpediaRoom copyWith({
    String? id,
    String? roomName,
    List<HotelDetailExpediaRatePlan>? rates,
    ExpediaHotelContentResponseRoom? roomMeta,
    List<ExpediRoomImageModel>? images,
  }) {
    return HotelDetailExpediaRoom(
      id: id ?? this.id,
      roomName: roomName ?? this.roomName,
      rates: rates ?? this.rates,
      roomMeta: roomMeta ?? this.roomMeta,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (roomName != null) {
      result.addAll({'roomName': roomName});
    }
    if (rates != null) {
      result.addAll({'rates': rates!.map((x) => x.toMap()).toList()});
    }
    if (roomMeta != null) {
      result.addAll({'roomMeta': roomMeta!.toMap()});
    }
    result.addAll({'images': images.map((x) => x.toMap()).toList()});

    return result;
  }

  factory HotelDetailExpediaRoom.fromMap(Map<String, dynamic> map) {
    return HotelDetailExpediaRoom(
      id: map['id'],
      roomName: map['roomName'],
      rates: map['rates'] != null
          ? List<HotelDetailExpediaRatePlan>.from(
              map['rates']?.map((x) => HotelDetailExpediaRatePlan.fromMap(x)))
          : null,
      roomMeta: map['roomMeta'] != null
          ? ExpediaHotelContentResponseRoom.fromMap(map['roomMeta'])
          : null,
      images: map['images'] != null
          ? List<ExpediRoomImageModel>.from(
              map['images']?.map((x) => ExpediRoomImageModel.fromMap(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailExpediaRoom.fromJson(String source) =>
      HotelDetailExpediaRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailExpediaRoom(id: $id, roomName: $roomName, rates: $rates, roomMeta: $roomMeta, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailExpediaRoom &&
        other.id == id &&
        other.roomName == roomName &&
        listEquals(other.rates, rates) &&
        other.roomMeta == roomMeta &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        roomName.hashCode ^
        rates.hashCode ^
        roomMeta.hashCode ^
        images.hashCode;
  }
}
