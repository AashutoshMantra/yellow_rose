import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/erro_code_handler.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_row.dart';

class AirSeatMapResponse {
  final List<SeatRow> airSeatRows;
  ErrorCodeHandler? errorDetails;
  AirSeatMapResponse({
    required this.airSeatRows,
    this.errorDetails,
  }) {
    airSeatRows.sort((a, b) => int.parse(a.row).compareTo(int.parse(b.row)));
  }

  AirSeatMapResponse copyWith({
    List<SeatRow>? airSeatRows,
    ErrorCodeHandler? errorDetails,
  }) {
    return AirSeatMapResponse(
      airSeatRows: airSeatRows ?? this.airSeatRows,
      errorDetails: errorDetails ?? this.errorDetails,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'airSeatRows': airSeatRows.map((x) => x.toMap()).toList()});
    if (errorDetails != null) {
      result.addAll({'errorDetails': errorDetails!.toMap()});
    }

    return result;
  }

  factory AirSeatMapResponse.fromMap(Map<String, dynamic> map) {
    return AirSeatMapResponse(
      airSeatRows: map['airSeatRows'] != null
          ? List<SeatRow>.from(
              map['airSeatRows']?.map((x) => SeatRow.fromMap(x)))
          : [],
      errorDetails: map['errorDetails'] != null
          ? ErrorCodeHandler.fromMap(map['errorDetails'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSeatMapResponse.fromJson(String source) =>
      AirSeatMapResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'AirSeatMapResponse(airSeatRows: $airSeatRows, errorDetails: $errorDetails)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirSeatMapResponse &&
        listEquals(other.airSeatRows, airSeatRows) &&
        other.errorDetails == errorDetails;
  }

  @override
  int get hashCode => airSeatRows.hashCode ^ errorDetails.hashCode;
}
