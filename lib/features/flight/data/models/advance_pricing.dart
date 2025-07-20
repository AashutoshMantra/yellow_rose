import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';
import 'package:yellow_rose/features/flight/data/models/passenger_type_enum.dart';

class AdvancedPricing {
  final PassengerTypeEnum? passengerType;
  final double feeAmt;
  final double baseAmt;
  final double taxAmt;
  AdvancedPricing({
    this.passengerType,
    required this.feeAmt,
    required this.baseAmt,
    required this.taxAmt,
  });

  AdvancedPricing copyWith({
    PassengerTypeEnum? passengerType,
    double? feeAmt,
    double? baseAmt,
    double? taxAmt,
  }) {
    return AdvancedPricing(
      passengerType: passengerType ?? this.passengerType,
      feeAmt: feeAmt ?? this.feeAmt,
      baseAmt: baseAmt ?? this.baseAmt,
      taxAmt: taxAmt ?? this.taxAmt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (passengerType != null) {
      result.addAll({'passengerType': passengerType!.name});
    }
    result.addAll({'feeAmt': feeAmt});
    result.addAll({'baseAmt': baseAmt});
    result.addAll({'taxAmt': taxAmt});

    return result;
  }

  factory AdvancedPricing.fromMap(Map<String, dynamic> map) {
    return AdvancedPricing(
      passengerType: (map['passengerType'] as String?)?.toEnum(PassengerTypeEnum.values),
      feeAmt: map['feeAmt']?.toDouble() ?? 0.0,
      baseAmt: map['baseAmt']?.toDouble() ?? 0.0,
      taxAmt: map['taxAmt']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvancedPricing.fromJson(String source) =>
      AdvancedPricing.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdvancedPricing(passengerType: $passengerType, feeAmt: $feeAmt, baseAmt: $baseAmt, taxAmt: $taxAmt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdvancedPricing &&
        other.passengerType == passengerType &&
        other.feeAmt == feeAmt &&
        other.baseAmt == baseAmt &&
        other.taxAmt == taxAmt;
  }

  @override
  int get hashCode {
    return passengerType.hashCode ^
        feeAmt.hashCode ^
        baseAmt.hashCode ^
        taxAmt.hashCode;
  }
}
