import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class AirSeat {
  final String? row;
  final String? column;
  final String? unitKey;

  final double baseFare;
  final double finalTax;
  final String? source;
  final String? supplier;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final Map<String, Object>? commercialData;
  AirSeat({
    this.row,
    this.column,
    this.unitKey,
    required this.baseFare,
    required this.finalTax,
    this.source,
    this.supplier,
    this.miscellaneousData,
    this.taxes,
    this.commercialData,
  });

  AirSeat copyWith({
    String? row,
    String? column,
    String? unitKey,
    double? baseFare,
    double? finalTax,
    String? source,
    String? supplier,
    Map<String, Object>? miscellaneousData,
    Map<String, List<double>>? taxes,
    Map<String, Object>? commercialData,
  }) {
    return AirSeat(
      row: row ?? this.row,
      column: column ?? this.column,
      unitKey: unitKey ?? this.unitKey,
      baseFare: baseFare ?? this.baseFare,
      finalTax: finalTax ?? this.finalTax,
      source: source ?? this.source,
      supplier: supplier ?? this.supplier,
      miscellaneousData: miscellaneousData ?? this.miscellaneousData,
      taxes: taxes ?? this.taxes,
      commercialData: commercialData ?? this.commercialData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (row != null) {
      result.addAll({'row': row});
    }
    if (column != null) {
      result.addAll({'column': column});
    }
    if (unitKey != null) {
      result.addAll({'unitKey': unitKey});
    }
    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if (source != null) {
      result.addAll({'source': source!});
    }
    if (supplier != null) {
      result.addAll({'supplier': supplier});
    }
    if (miscellaneousData != null) {
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if (taxes != null) {
      result.addAll({'taxes': taxes});
    }
    if (commercialData != null) {
      result.addAll({'commercialData': commercialData});
    }

    return result;
  }

  factory AirSeat.fromMap(Map<String, dynamic> map) {
    return AirSeat(
      row: map['row'],
      column: map['column'],
      unitKey: map['unitKey'],
      baseFare: map['baseFare']?.toDouble() ?? 0.0,
      finalTax: map['finalTax']?.toDouble() ?? 0.0,
      source: map['source'],
      supplier: map['supplier'],
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
          ? Map<String, Object>.from(map['commercialData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AirSeat.fromJson(String source) =>
      AirSeat.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AirSeat(row: $row, column: $column, unitKey: $unitKey, baseFare: $baseFare, finalTax: $finalTax, source: $source, supplier: $supplier, miscellaneousData: $miscellaneousData, taxes: $taxes, commercialData: $commercialData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AirSeat &&
        other.row == row &&
        other.column == column &&
        other.unitKey == unitKey &&
        other.baseFare == baseFare &&
        other.finalTax == finalTax &&
        other.source == source &&
        other.supplier == supplier &&
        mapEquals(other.miscellaneousData, miscellaneousData) &&
        mapEquals(other.taxes, taxes) &&
        mapEquals(other.commercialData, commercialData);
  }

  @override
  int get hashCode {
    return row.hashCode ^
        column.hashCode ^
        unitKey.hashCode ^
        baseFare.hashCode ^
        finalTax.hashCode ^
        source.hashCode ^
        supplier.hashCode ^
        miscellaneousData.hashCode ^
        taxes.hashCode ^
        commercialData.hashCode;
  }
}
