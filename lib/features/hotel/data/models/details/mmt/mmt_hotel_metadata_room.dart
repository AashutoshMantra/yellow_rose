import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_hotel_metadata_bed.dart';

class MMTHotelMetadataRoom {
  final String? code;
  final String? name;
  final String? bedRoomCount;
  final String? roomSize;
  final List<MMTHotelMetadataBed>? beds;
  final int? maxGuestCount;
  final String? view;
  final int? maxChildrenCount;
  MMTHotelMetadataRoom({
    this.code,
    this.name,
    this.bedRoomCount,
    this.roomSize,
    this.beds,
    this.maxGuestCount,
    this.view,
    this.maxChildrenCount,
  });

  MMTHotelMetadataRoom copyWith({
    String? code,
    String? name,
    String? bedRoomCount,
    String? roomSize,
    List<MMTHotelMetadataBed>? beds,
    int? maxGuestCount,
    String? view,
    int? maxChildrenCount,
  }) {
    return MMTHotelMetadataRoom(
      code: code ?? this.code,
      name: name ?? this.name,
      bedRoomCount: bedRoomCount ?? this.bedRoomCount,
      roomSize: roomSize ?? this.roomSize,
      beds: beds ?? this.beds,
      maxGuestCount: maxGuestCount ?? this.maxGuestCount,
      view: view ?? this.view,
      maxChildrenCount: maxChildrenCount ?? this.maxChildrenCount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(code != null){
      result.addAll({'code': code});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(bedRoomCount != null){
      result.addAll({'bedRoomCount': bedRoomCount});
    }
    if(roomSize != null){
      result.addAll({'roomSize': roomSize});
    }
    if(beds != null){
      result.addAll({'beds': beds!.map((x) => x?.toMap()).toList()});
    }
    if(maxGuestCount != null){
      result.addAll({'maxGuestCount': maxGuestCount});
    }
    if(view != null){
      result.addAll({'view': view});
    }
    if(maxChildrenCount != null){
      result.addAll({'maxChildrenCount': maxChildrenCount});
    }
  
    return result;
  }

  factory MMTHotelMetadataRoom.fromMap(Map<String, dynamic> map) {
    return MMTHotelMetadataRoom(
      code: map['code'],
      name: map['name'],
      bedRoomCount: map['bedRoomCount'],
      roomSize: map['roomSize'],
      beds: map['beds'] != null ? List<MMTHotelMetadataBed>.from(map['beds']?.map((x) => MMTHotelMetadataBed.fromMap(x))) : null,
      maxGuestCount: map['maxGuestCount']?.toInt(),
      view: map['view'],
      maxChildrenCount: map['maxChildrenCount']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelMetadataRoom.fromJson(String source) => MMTHotelMetadataRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MMTHotelMetadataRoom(code: $code, name: $name, bedRoomCount: $bedRoomCount, roomSize: $roomSize, beds: $beds, maxGuestCount: $maxGuestCount, view: $view, maxChildrenCount: $maxChildrenCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MMTHotelMetadataRoom &&
      other.code == code &&
      other.name == name &&
      other.bedRoomCount == bedRoomCount &&
      other.roomSize == roomSize &&
      listEquals(other.beds, beds) &&
      other.maxGuestCount == maxGuestCount &&
      other.view == view &&
      other.maxChildrenCount == maxChildrenCount;
  }

  @override
  int get hashCode {
    return code.hashCode ^
      name.hashCode ^
      bedRoomCount.hashCode ^
      roomSize.hashCode ^
      beds.hashCode ^
      maxGuestCount.hashCode ^
      view.hashCode ^
      maxChildrenCount.hashCode;
  }
}
