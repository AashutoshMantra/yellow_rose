import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/data/models/commercial_data.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/air_seat_row_characteristics.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_occupancy.dart';

enum SeatCharacteristics {
  AISLE_SEAT("Asile Seat"),

  WINDOW_SEAT("Window Seat"),

  RESTRICTED_SEAT("Restricted Seat"),

  EXIT_ROW("ExitRow"),

  NO_SEAT("No Seat"),
  NORMAL_SEAT("Normal Seat"),

  RESTRICTED_RECLINE("Restricted Recline"),

  CHARGEABLE_SEAT("Chargable Seat");

  final String seatAttrString;

  const SeatCharacteristics(this.seatAttrString);
  static List<SeatCharacteristics> blockedSeats() {
    return [
      SeatCharacteristics.RESTRICTED_SEAT,
      SeatCharacteristics.NO_SEAT,
      SeatCharacteristics.RESTRICTED_RECLINE
    ];
  }
}

class SeatRow {
  final String row;
  final List<AirSeat> airSeats;
  final List<AirSeatRowCharacteristics>? airSeatRowCharacteristics;
  SeatRow({
    required this.row,
    required this.airSeats,
    this.airSeatRowCharacteristics,
  });

  SeatRow copyWith({
    String? row,
    List<AirSeat>? airSeats,
    List<AirSeatRowCharacteristics>? airSeatRowCharacteristics,
  }) {
    return SeatRow(
      row: row ?? this.row,
      airSeats: airSeats ?? this.airSeats,
      airSeatRowCharacteristics:
          airSeatRowCharacteristics ?? this.airSeatRowCharacteristics,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'row': row});
    result.addAll({'airSeats': airSeats.map((x) => x.toMap()).toList()});
    result.addAll({
      'airSeatRowCharacteristics':
          airSeatRowCharacteristics?.map((x) => x.name).toList()
    });

    return result;
  }

  factory SeatRow.fromMap(Map<String, dynamic> map) {
    return SeatRow(
      row: map['row'] ?? '',
      airSeats:
          List<AirSeat>.from(map['airSeats']?.map((x) => AirSeat.fromMap(x))),
      airSeatRowCharacteristics: map['airSeatRowCharacteristics'] != null
          ? List<AirSeatRowCharacteristics>.from(
              map['airSeatRowCharacteristics']
                  ?.map(
                      (x) => stringToEnum(x, AirSeatRowCharacteristics.values))
                  .where((x) => x != null)).toList()
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SeatRow.fromJson(String source) =>
      SeatRow.fromMap(json.decode(source));

  @override
  String toString() =>
      'SeatRow(row: $row, airSeats: $airSeats, airSeatRowCharacteristics: $airSeatRowCharacteristics)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SeatRow &&
        other.row == row &&
        listEquals(other.airSeats, airSeats) &&
        listEquals(other.airSeatRowCharacteristics, airSeatRowCharacteristics);
  }

  @override
  int get hashCode =>
      row.hashCode ^ airSeats.hashCode ^ airSeatRowCharacteristics.hashCode;
}
