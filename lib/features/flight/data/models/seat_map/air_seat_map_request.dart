import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/custom_pax_detail.dart';

class AirSeatMapRequest {
    String? OrderId;
    final String fromAirport;
    final String toAirport;
    final List<CustomPaxDetails>? paxDetails;
    ErrorCodeHandler? errorDetails;
  AirSeatMapRequest({
    this.OrderId,
    required this.fromAirport,
    required this.toAirport,
    this.paxDetails,
    this.errorDetails,
  });

  AirSeatMapRequest copyWith({
    String? OrderId,
    String? fromAirport,
    String? toAirport,
    List<CustomPaxDetails>? paxDetails,
    ErrorCodeHandler? errorDetails,
  }) {
    return AirSeatMapRequest(
      OrderId: OrderId ?? this.OrderId,
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      paxDetails: paxDetails ?? this.paxDetails,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(OrderId != null){
      result.addAll({'OrderId': OrderId});
    }
    result.addAll({'fromAirport': fromAirport});
    result.addAll({'toAirport': toAirport});
    if(paxDetails != null){
      result.addAll({'paxDetails': paxDetails!.map((x) => x?.toMap()).toList()});
    }
    if(errorDetails != null){
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }
  
    return result;
  }

  factory AirSeatMapRequest.fromMap(Map<String, dynamic> map) {
    return AirSeatMapRequest(
      OrderId: map['OrderId'],
      fromAirport: map['fromAirport'] ?? '',
      toAirport: map['toAirport'] ?? '',
      paxDetails: map['paxDetails'] != null ? List<CustomPaxDetails>.from(map['paxDetails']?.map((x) => CustomPaxDetails.fromMap(x))) : null,
      errorDetails: map['errorDetails'] != null ? ErrorCodeHandler.fromMap(map['errorDetails']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSeatMapRequest.fromJson(String source) => AirSeatMapRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AirSeatMapRequest(OrderId: $OrderId, fromAirport: $fromAirport, toAirport: $toAirport, paxDetails: $paxDetails, errorDetails: $errorDetails)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AirSeatMapRequest &&
      other.OrderId == OrderId &&
      other.fromAirport == fromAirport &&
      other.toAirport == toAirport &&
      listEquals(other.paxDetails, paxDetails) &&
      other.errorDetails == errorDetails;
  }

  @override
  int get hashCode {
    return OrderId.hashCode ^
      fromAirport.hashCode ^
      toAirport.hashCode ^
      paxDetails.hashCode ^
      errorDetails.hashCode;
  }
}
