import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/hotel/data/models/order/expedia/expedia_booking_response.dart';
import 'package:yellow_rose/features/hotel/data/models/order/mmt/mmt_booking_response.dart';

class HotelBookingResponse {
  final String source;

  final ErrorCodeHandler? error;

  final List<MmtBookingResponse>? mmtBookingResponse;
  final List<ExpediaBookingResponse>? expediaBookingResponse;
  HotelBookingResponse({
    required this.source,
    this.error,
    this.mmtBookingResponse,
    this.expediaBookingResponse,
  });

  HotelBookingResponse copyWith({
    String? source,
    ErrorCodeHandler? error,
    List<MmtBookingResponse>? mmtBookingResponse,
    List<ExpediaBookingResponse>? expediaBookingResponse,
  }) {
    return HotelBookingResponse(
      source: source ?? this.source,
      error: error ?? this.error,
      mmtBookingResponse: mmtBookingResponse ?? this.mmtBookingResponse,
      expediaBookingResponse: expediaBookingResponse ?? this.expediaBookingResponse,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'source': source});
    if(error != null){
      result.addAll({'error': error!.toMap()});
    }
    if(mmtBookingResponse != null){
      result.addAll({'mmtBookingResponse': mmtBookingResponse!.map((x) => x?.toMap()).toList()});
    }
    if(expediaBookingResponse != null){
      result.addAll({'expediaBookingResponse': expediaBookingResponse!.map((x) => x?.toMap()).toList()});
    }
  
    return result;
  }

  factory HotelBookingResponse.fromMap(Map<String, dynamic> map) {
    return HotelBookingResponse(
      source: map['source'] ?? '',
      error: map['error'] != null ? ErrorCodeHandler.fromMap(map['error']) : null,
      mmtBookingResponse: map['mmtBookingResponse'] != null ? List<MmtBookingResponse>.from(map['mmtBookingResponse']?.map((x) => MmtBookingResponse.fromMap(x))) : null,
      expediaBookingResponse: map['expediaBookingResponse'] != null ? List<ExpediaBookingResponse>.from(map['expediaBookingResponse']?.map((x) => ExpediaBookingResponse.fromMap(x))) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelBookingResponse.fromJson(String source) => HotelBookingResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelBookingResponse(source: $source, error: $error, mmtBookingResponse: $mmtBookingResponse, expediaBookingResponse: $expediaBookingResponse)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is HotelBookingResponse &&
      other.source == source &&
      other.error == error &&
      listEquals(other.mmtBookingResponse, mmtBookingResponse) &&
      listEquals(other.expediaBookingResponse, expediaBookingResponse);
  }

  @override
  int get hashCode {
    return source.hashCode ^
      error.hashCode ^
      mmtBookingResponse.hashCode ^
      expediaBookingResponse.hashCode;
  }
}
