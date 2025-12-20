import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/commercial_data.dart';

class SsrOption {
  final CommercialData? commercialData;
  final String? source;
  final String code;
  final String? type;
  final String? description;
  final String? ssrKey;
  final double baseFare;
  final double finalTax;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final bool? bundled;

  SsrOption({
    this.commercialData,
    this.source,
    required this.code,
    this.type,
    this.description,
    this.ssrKey,
    this.baseFare = 0,
    this.finalTax = 0,
    this.miscellaneousData,
    this.taxes,
    this.bundled,
  });

  SsrOption copyWith({
    CommercialData? commercialData,
    String? source,
    String? code,
    String? type,
    String? description,
    String? ssrKey,
    double? baseFare,
    double? finalTax,
    Map<String, Object>? miscellaneousData,
    Map<String, List<double>>? taxes,
    bool? bundled,
  }) {
    return SsrOption(
      commercialData: commercialData ?? this.commercialData,
      source: source ?? this.source,
      code: code ?? this.code,
      type: type ?? this.type,
      description: description ?? this.description,
      ssrKey: ssrKey ?? this.ssrKey,
      baseFare: baseFare ?? this.baseFare,
      finalTax: finalTax ?? this.finalTax,
      miscellaneousData: miscellaneousData ?? this.miscellaneousData,
      taxes: taxes ?? this.taxes,
      bundled: bundled ?? this.bundled,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (commercialData != null) {
      result.addAll({'commercialData': commercialData!.toMap()});
    }
    if (source != null) {
      result.addAll({'source': source});
    }
    result.addAll({'code': code});
    if (type != null) {
      result.addAll({'type': type});
    }
    if (description != null) {
      result.addAll({'description': description});
    }
    if (ssrKey != null) {
      result.addAll({'ssrKey': ssrKey});
    }
    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if (miscellaneousData != null) {
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if (taxes != null) {
      result.addAll({'taxes': taxes});
    }
    if (bundled != null) {
      result.addAll({'bundled': bundled});
    }

    return result;
  }

  factory SsrOption.fromMap(Map<String, dynamic> map) {
    return SsrOption(
      commercialData: map['commercialData'] != null
          ? CommercialData.fromMap(map['commercialData'])
          : null,
      source: map['source'],
      code: map['code'] ?? '',
      type: map['type'],
      description: map['description'],
      ssrKey: map['ssrKey'],
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
      bundled: map['bundled'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SsrOption.fromJson(String source) =>
      SsrOption.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SsrOption(commercialData: $commercialData, source: $source, code: $code, type: $type, description: $description, ssrKey: $ssrKey, baseFare: $baseFare, finalTax: $finalTax, miscellaneousData: $miscellaneousData, taxes: $taxes, bundled: $bundled)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SsrOption &&
        other.commercialData == commercialData &&
        other.source == source &&
        other.code == code &&
        other.type == type &&
        other.description == description &&
        other.ssrKey == ssrKey &&
        other.baseFare == baseFare &&
        other.finalTax == finalTax &&
        mapEquals(other.miscellaneousData, miscellaneousData) &&
        mapEquals(other.taxes, taxes) &&
        other.bundled == bundled;
  }

  @override
  int get hashCode {
    return commercialData.hashCode ^
        source.hashCode ^
        code.hashCode ^
        type.hashCode ^
        description.hashCode ^
        ssrKey.hashCode ^
        baseFare.hashCode ^
        finalTax.hashCode ^
        miscellaneousData.hashCode ^
        taxes.hashCode ^
        bundled.hashCode;
  }

  double get totalCost {
    return baseFare + finalTax;
  }
}
