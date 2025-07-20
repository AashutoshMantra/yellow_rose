import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/commercial_data.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_occupancy.dart';
import 'package:yellow_rose/features/flight/data/models/seat_map/seat_row.dart';

class AirSeat {
  final double baseFare;
  final double finalTax;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final CommercialData? commercialData;
  final String column;
  final List<SeatCharacteristics>? seatCharacteristics;
  final SeatOccupancy seatOccupancy;
  final String? unitKey;
  AirSeat({
    this.baseFare = 0,
    this.finalTax = 0,
    this.miscellaneousData,
    this.taxes,
    this.commercialData,
    required this.column,
    this.seatCharacteristics,
    required this.seatOccupancy,
    this.unitKey,
  });

  AirSeat copyWith({
    double? baseFare,
    double? finalTax,
    Map<String, Object>? miscellaneousData,
    Map<String, List<double>>? taxes,
    CommercialData? commercialData,
    String? column,
    List<SeatCharacteristics>? seatCharacteristics,
    SeatOccupancy? seatOccupancy,
    String? unitKey,
  }) {
    return AirSeat(
      baseFare: baseFare ?? this.baseFare,
      finalTax: finalTax ?? this.finalTax,
      miscellaneousData: miscellaneousData ?? this.miscellaneousData,
      taxes: taxes ?? this.taxes,
      commercialData: commercialData ?? this.commercialData,
      column: column ?? this.column,
      seatCharacteristics: seatCharacteristics ?? this.seatCharacteristics,
      seatOccupancy: seatOccupancy ?? this.seatOccupancy,
      unitKey: unitKey ?? this.unitKey,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if (miscellaneousData != null) {
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if (taxes != null) {
      result.addAll({'taxes': taxes});
    }
    if (commercialData != null) {
      result.addAll({'commercialData': commercialData!.toMap()});
    }
    result.addAll({'column': column});
    if (seatCharacteristics != null) {
      result.addAll({
        'seatCharacteristics': seatCharacteristics!.map((x) => x.name).toList()
      });
    }
    result.addAll({'seatOccupancy': seatOccupancy.name});
    if (unitKey != null) {
      result.addAll({'unitKey': unitKey});
    }

    return result;
  }

  factory AirSeat.fromMap(Map<String, dynamic> map) {
    return AirSeat(
      baseFare: map['baseFare']?.toDouble() ?? 0.0,
      finalTax: map['finalTax']?.toDouble() ?? 0.0,
      miscellaneousData: map['miscellaneousData'] != null
          ? Map<String, Object>.from(map['miscellaneousData'])
          : null,
      taxes: map['taxes'] != null
          ? (map['taxes'] as Map).map<String, List<double>>(
              (key, value) => MapEntry(
                key.toString(), // Ensure key is a String
                (value as List).map((e) => (e as num).toDouble()).toList(),
              ),
            )
          : null,
      commercialData: map['commercialData'] != null
          ? CommercialData.fromMap(map['commercialData'])
          : null,
      column: map['column'] ?? '',
      seatCharacteristics: map['seatCharacteristics'] != null
          ? List<SeatCharacteristics>.from(map['seatCharacteristics']
              ?.map((x) => stringToEnum(x, SeatCharacteristics.values))
              .where((x) => x != null))
          : null,
      seatOccupancy: stringToEnum(map['seatOccupancy'], SeatOccupancy.values) ??
          SeatOccupancy.Blocked,
      unitKey: map['unitKey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSeat.fromJson(String source) =>
      AirSeat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AirSeat(baseFare: $baseFare, finalTax: $finalTax, miscellaneousData: $miscellaneousData, taxes: $taxes, commercialData: $commercialData, column: $column, seatCharacteristics: $seatCharacteristics, seatOccupancy: $seatOccupancy, unitKey: $unitKey)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirSeat &&
        other.baseFare == baseFare &&
        other.finalTax == finalTax &&
        mapEquals(other.miscellaneousData, miscellaneousData) &&
        mapEquals(other.taxes, taxes) &&
        other.commercialData == commercialData &&
        other.column == column &&
        listEquals(other.seatCharacteristics, seatCharacteristics) &&
        other.seatOccupancy == seatOccupancy &&
        other.unitKey == unitKey;
  }

  @override
  int get hashCode {
    return baseFare.hashCode ^
        finalTax.hashCode ^
        miscellaneousData.hashCode ^
        taxes.hashCode ^
        commercialData.hashCode ^
        column.hashCode ^
        seatCharacteristics.hashCode ^
        seatOccupancy.hashCode ^
        unitKey.hashCode;
  }

  get isFree {
    return baseFare + finalTax == 0;
  }

  bool get isRestricted {
    return (seatCharacteristics == null || seatCharacteristics!.isEmpty) ||
        seatCharacteristics?.any((characteristics) =>
                SeatCharacteristics.blockedSeats().contains(characteristics)) ==
            true;
  }

  double get totalCost {
    return baseFare + finalTax;
  }
}
