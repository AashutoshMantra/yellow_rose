import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';

class ExpediaBookingResponse {
  final String? itineraryId;
  final List<String>? subItineraryIds;
  final ErrorCodeHandler? error;
  ExpediaBookingResponse({
    this.itineraryId,
    this.subItineraryIds,
    this.error,
  });

  ExpediaBookingResponse copyWith({
    String? itineraryId,
    List<String>? subItineraryIds,
    ErrorCodeHandler? error,
  }) {
    return ExpediaBookingResponse(
      itineraryId: itineraryId ?? this.itineraryId,
      subItineraryIds: subItineraryIds ?? this.subItineraryIds,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(itineraryId != null){
      result.addAll({'itineraryId': itineraryId});
    }
    if(subItineraryIds != null){
      result.addAll({'subItineraryIds': subItineraryIds});
    }
    if(error != null){
      result.addAll({'error': error!.toMap()});
    }
  
    return result;
  }

  factory ExpediaBookingResponse.fromMap(Map<String, dynamic> map) {
    return ExpediaBookingResponse(
      itineraryId: map['itineraryId'],
      subItineraryIds: List<String>.from(map['subItineraryIds']),
      error: map['error'] != null ? ErrorCodeHandler.fromMap(map['error']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaBookingResponse.fromJson(String source) => ExpediaBookingResponse.fromMap(json.decode(source));

  @override
  String toString() => 'ExpediaBookingResponse(itineraryId: $itineraryId, subItineraryIds: $subItineraryIds, error: $error)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaBookingResponse &&
      other.itineraryId == itineraryId &&
      listEquals(other.subItineraryIds, subItineraryIds) &&
      other.error == error;
  }

  @override
  int get hashCode => itineraryId.hashCode ^ subItineraryIds.hashCode ^ error.hashCode;
}
