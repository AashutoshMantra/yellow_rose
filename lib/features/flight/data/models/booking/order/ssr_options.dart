import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:yellow_rose/core/utils/extensions.dart';

import 'package:yellow_rose/features/flight/domain/entities/air_sources.dart';

class SSROptions {
  final String? code;
  final String? type;
  final String? ssrKey;
  final String? description;

  final double baseFare;
  final double finalTax;
  final String? source;
  final String? supplier;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final Map<String, Object>? commercialData;
  SSROptions({
    this.code,
    this.type,
    this.ssrKey,
    this.description,
    required this.baseFare,
    required this.finalTax,
    this.source,
    this.supplier,
    this.miscellaneousData,
    this.taxes,
    this.commercialData,
  });

  SSROptions copyWith({
    String? code,
    String? type,
    String? ssrKey,
    String? description,
    double? baseFare,
    double? finalTax,
    String? source,
    String? supplier,
    Map<String, Object>? miscellaneousData,
    Map<String, List<double>>? taxes,
    Map<String, Object>? commercialData,
  }) {
    return SSROptions(
      code: code ?? this.code,
      type: type ?? this.type,
      ssrKey: ssrKey ?? this.ssrKey,
      description: description ?? this.description,
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

    if (code != null) {
      result.addAll({'code': code});
    }
    if (type != null) {
      result.addAll({'type': type});
    }
    if (ssrKey != null) {
      result.addAll({'ssrKey': ssrKey});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if (source != null) {
      result.addAll({'source': source});
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

  factory SSROptions.fromMap(Map<String, dynamic> map) {
    return SSROptions(
      code: map['code'],
      type: map['type'],
      ssrKey: map['ssrKey'],
      description: map['description'],
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

  factory SSROptions.fromJson(String source) =>
      SSROptions.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SSROptions(code: $code, type: $type, ssrKey: $ssrKey, description: $description, baseFare: $baseFare, finalTax: $finalTax, source: $source, supplier: $supplier, miscellaneousData: $miscellaneousData, taxes: $taxes, commercialData: $commercialData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SSROptions &&
        other.code == code &&
        other.type == type &&
        other.ssrKey == ssrKey &&
        other.description == description &&
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
    return code.hashCode ^
        type.hashCode ^
        ssrKey.hashCode ^
        description.hashCode ^
        baseFare.hashCode ^
        finalTax.hashCode ^
        source.hashCode ^
        supplier.hashCode ^
        miscellaneousData.hashCode ^
        taxes.hashCode ^
        commercialData.hashCode;
  }
}
