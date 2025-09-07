import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/search_detail_res_hotel.dart';

class HotelDetailResponse {
  final String? mmtRequestId;
  final int? agodaSearchId;
  final String? expediaSessionId;

  final SearchDetailRespHotels? hotel;
  HotelDetailResponse({
    this.mmtRequestId,
    this.agodaSearchId,
    this.expediaSessionId,
    this.hotel,
  });

  HotelDetailResponse copyWith({
    String? mmtRequestId,
    int? agodaSearchId,
    String? expediaSessionId,
    SearchDetailRespHotels? hotel,
  }) {
    return HotelDetailResponse(
      mmtRequestId: mmtRequestId ?? this.mmtRequestId,
      agodaSearchId: agodaSearchId ?? this.agodaSearchId,
      expediaSessionId: expediaSessionId ?? this.expediaSessionId,
      hotel: hotel ?? this.hotel,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(mmtRequestId != null){
      result.addAll({'mmtRequestId': mmtRequestId});
    }
    if(agodaSearchId != null){
      result.addAll({'agodaSearchId': agodaSearchId});
    }
    if(expediaSessionId != null){
      result.addAll({'expediaSessionId': expediaSessionId});
    }
    if(hotel != null){
      result.addAll({'hotel': hotel!.toMap()});
    }
  
    return result;
  }

  factory HotelDetailResponse.fromMap(Map<String, dynamic> map) {
    return HotelDetailResponse(
      mmtRequestId: map['mmtRequestId'],
      agodaSearchId: map['agodaSearchId']?.toInt(),
      expediaSessionId: map['expediaSessionId'],
      hotel: map['hotel'] != null ? SearchDetailRespHotels.fromMap(map['hotel']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailResponse.fromJson(String source) => HotelDetailResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailResponse(mmtRequestId: $mmtRequestId, agodaSearchId: $agodaSearchId, expediaSessionId: $expediaSessionId, hotel: $hotel)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelDetailResponse &&
      other.mmtRequestId == mmtRequestId &&
      other.agodaSearchId == agodaSearchId &&
      other.expediaSessionId == expediaSessionId &&
      other.hotel == hotel;
  }

  @override
  int get hashCode {
    return mmtRequestId.hashCode ^
      agodaSearchId.hashCode ^
      expediaSessionId.hashCode ^
      hotel.hashCode;
  }
}
