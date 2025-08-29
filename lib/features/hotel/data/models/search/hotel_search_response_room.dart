import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/search/hoter_search_room_rate.dart';

class HotelSearchResponseRoom {
    final String? roomSource;
    final String? code;
    final String? name;
    final String? blockId;

    final String? ratePlanId;
    final bool? freeBreakfast;
    final bool? freeCancellation;
    final HotelSearchResRoomRate? rate;
  HotelSearchResponseRoom({
    this.roomSource,
    this.code,
    this.name,
    this.blockId,
    this.ratePlanId,
    this.freeBreakfast,
    this.freeCancellation,
    this.rate,
  });


  HotelSearchResponseRoom copyWith({
    String? roomSource,
    String? code,
    String? name,
    String? blockId,
    String? ratePlanId,
    bool? freeBreakfast,
    bool? freeCancellation,
    HotelSearchResRoomRate? rate,
  }) {
    return HotelSearchResponseRoom(
      roomSource: roomSource ?? this.roomSource,
      code: code ?? this.code,
      name: name ?? this.name,
      blockId: blockId ?? this.blockId,
      ratePlanId: ratePlanId ?? this.ratePlanId,
      freeBreakfast: freeBreakfast ?? this.freeBreakfast,
      freeCancellation: freeCancellation ?? this.freeCancellation,
      rate: rate ?? this.rate,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(roomSource != null){
      result.addAll({'roomSource': roomSource});
    }
    if(code != null){
      result.addAll({'code': code});
    }
    if(name != null){
      result.addAll({'name': name});
    }
    if(blockId != null){
      result.addAll({'blockId': blockId});
    }
    if(ratePlanId != null){
      result.addAll({'ratePlanId': ratePlanId});
    }
    if(freeBreakfast != null){
      result.addAll({'freeBreakfast': freeBreakfast});
    }
    if(freeCancellation != null){
      result.addAll({'freeCancellation': freeCancellation});
    }
    if(rate != null){
      result.addAll({'rate': rate!.toMap()});
    }
  
    return result;
  }

  factory HotelSearchResponseRoom.fromMap(Map<String, dynamic> map) {
    return HotelSearchResponseRoom(
      roomSource: map['roomSource'],
      code: map['code'],
      name: map['name'],
      blockId: map['blockId'],
      ratePlanId: map['ratePlanId'],
      freeBreakfast: map['freeBreakfast'],
      freeCancellation: map['freeCancellation'],
      rate: map['rate'] != null ? HotelSearchResRoomRate.fromMap(map['rate']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelSearchResponseRoom.fromJson(String source) => HotelSearchResponseRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelSearchResponseRoom(roomSource: $roomSource, code: $code, name: $name, blockId: $blockId, ratePlanId: $ratePlanId, freeBreakfast: $freeBreakfast, freeCancellation: $freeCancellation, rate: $rate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelSearchResponseRoom &&
      other.roomSource == roomSource &&
      other.code == code &&
      other.name == name &&
      other.blockId == blockId &&
      other.ratePlanId == ratePlanId &&
      other.freeBreakfast == freeBreakfast &&
      other.freeCancellation == freeCancellation &&
      other.rate == rate;
  }

  @override
  int get hashCode {
    return roomSource.hashCode ^
      code.hashCode ^
      name.hashCode ^
      blockId.hashCode ^
      ratePlanId.hashCode ^
      freeBreakfast.hashCode ^
      freeCancellation.hashCode ^
      rate.hashCode;
  }
}
