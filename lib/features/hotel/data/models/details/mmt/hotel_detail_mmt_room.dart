import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/mmt/hotel_detail_mmt_rate_plan.dart';
import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_metadata_room.dart';

class HotelDetailMmtRoom {
  final String? name;
  final String? code;
  final MMTHotelMetadataRoom? metadata;
  final List<String>? media;
  final List<HotelDetailMMTRatePlan>? ratePlans;
  final double? totalAmount;
  HotelDetailMmtRoom({
    this.name,
    this.code,
    this.metadata,
    this.media,
    this.ratePlans,
    this.totalAmount,
  });

  HotelDetailMmtRoom copyWith({
    String? name,
    String? code,
    MMTHotelMetadataRoom? metadata,
    List<String>? media,
    List<HotelDetailMMTRatePlan>? ratePlans,
    double? totalAmount,
  }) {
    return HotelDetailMmtRoom(
      name: name ?? this.name,
      code: code ?? this.code,
      metadata: metadata ?? this.metadata,
      media: media ?? this.media,
      ratePlans: ratePlans ?? this.ratePlans,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(name != null){
      result.addAll({'name': name});
    }
    if(code != null){
      result.addAll({'code': code});
    }
    if(metadata != null){
      result.addAll({'metadata': metadata!.toMap()});
    }
    if(media != null){
      result.addAll({'media': media});
    }
    if(ratePlans != null){
      result.addAll({'ratePlans': ratePlans!.map((x) => x?.toMap()).toList()});
    }
    if(totalAmount != null){
      result.addAll({'totalAmount': totalAmount});
    }
  
    return result;
  }

  factory HotelDetailMmtRoom.fromMap(Map<String, dynamic> map) {
    return HotelDetailMmtRoom(
      name: map['name'],
      code: map['code'],
      metadata: map['metadata'] != null ? MMTHotelMetadataRoom.fromMap(map['metadata']) : null,
      media: List<String>.from(map['media']),
      ratePlans: map['ratePlans'] != null ? List<HotelDetailMMTRatePlan>.from(map['ratePlans']?.map((x) => HotelDetailMMTRatePlan.fromMap(x))) : null,
      totalAmount: map['totalAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailMmtRoom.fromJson(String source) =>
      HotelDetailMmtRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailMmtRoom(name: $name, code: $code, metadata: $metadata, media: $media, ratePlans: $ratePlans, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelDetailMmtRoom &&
      other.name == name &&
      other.code == code &&
      other.metadata == metadata &&
      listEquals(other.media, media) &&
      listEquals(other.ratePlans, ratePlans) &&
      other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      code.hashCode ^
      metadata.hashCode ^
      media.hashCode ^
      ratePlans.hashCode ^
      totalAmount.hashCode;
  }
}
