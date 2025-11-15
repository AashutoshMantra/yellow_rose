import 'dart:convert';

import 'package:flutter/foundation.dart';

class RedbusCommercial {
  final double? totalFare = 0.0;
  final double? serviceTaxAbsolute = 0.0;
  final double? rootMarkup = 0.0;
  final double? userMarkup = 0.0;
  final double? totalMarkup = 0.0;
  final List<String>? markupDesc;
  final double? charge = 0.0;
  final double? tax = 0.0;
  final List<String>? chargeDesc;
  RedbusCommercial({
    this.markupDesc,
    this.chargeDesc,
  });
  final double? addOnCost = 0.0;
  final double? addOnCostGst = 0.0;

  RedbusCommercial copyWith({
    List<String>? markupDesc,
    List<String>? chargeDesc,
  }) {
    return RedbusCommercial(
      markupDesc: markupDesc ?? this.markupDesc,
      chargeDesc: chargeDesc ?? this.chargeDesc,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (markupDesc != null) {
      result.addAll({'markupDesc': markupDesc});
    }
    if (chargeDesc != null) {
      result.addAll({'chargeDesc': chargeDesc});
    }

    return result;
  }

  factory RedbusCommercial.fromMap(Map<String, dynamic> map) {
    return RedbusCommercial(
      markupDesc: List<String>.from(map['markupDesc']),
      chargeDesc: List<String>.from(map['chargeDesc']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RedbusCommercial.fromJson(String source) =>
      RedbusCommercial.fromMap(json.decode(source));

  @override
  String toString() =>
      'RedbusCommercial(markupDesc: $markupDesc, chargeDesc: $chargeDesc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RedbusCommercial &&
        listEquals(other.markupDesc, markupDesc) &&
        listEquals(other.chargeDesc, chargeDesc);
  }

  @override
  int get hashCode => markupDesc.hashCode ^ chargeDesc.hashCode;
}
