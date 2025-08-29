import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/search_detail_res_hotel.dart';

class HotelDetailResponse {
  final String? mmtRequestId;
  final int? agodaSearchId;

  final SearchDetailRespHotels? hotel;
  HotelDetailResponse({
    this.mmtRequestId,
    this.agodaSearchId,
    this.hotel,
  });

  HotelDetailResponse copyWith({
    String? mmtRequestId,
    int? agodaSearchId,
    SearchDetailRespHotels? hotel,
  }) {
    return HotelDetailResponse(
      mmtRequestId: mmtRequestId ?? this.mmtRequestId,
      agodaSearchId: agodaSearchId ?? this.agodaSearchId,
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
    if(hotel != null){
      result.addAll({'hotel': hotel!.toMap()});
    }
  
    return result;
  }

  factory HotelDetailResponse.fromMap(Map<String, dynamic> map) {
    return HotelDetailResponse(
      mmtRequestId: map['mmtRequestId'],
      agodaSearchId: map['agodaSearchId']?.toInt(),
      hotel: map['hotel'] != null ? SearchDetailRespHotels.fromMap(map['hotel']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailResponse.fromJson(String source) => HotelDetailResponse.fromMap(json.decode(source));

  @override
  String toString() => 'HotelDetailResponse(mmtRequestId: $mmtRequestId, agodaSearchId: $agodaSearchId, hotel: $hotel)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelDetailResponse &&
      other.mmtRequestId == mmtRequestId &&
      other.agodaSearchId == agodaSearchId &&
      other.hotel == hotel;
  }

  @override
  int get hashCode => mmtRequestId.hashCode ^ agodaSearchId.hashCode ^ hotel.hashCode;
}
