import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/advance_pricing.dart';

class AdvancedPricingSegment {
  final String? fromAirport;
  final String? toAirport;
  final List<AdvancedPricing> advancedPricingList;

  final double totalTaxAmt;
  final double totalFeeAmt;
  final double totalBaseAmt;
  AdvancedPricingSegment({
    this.fromAirport,
    this.toAirport,
    required this.advancedPricingList,
    required this.totalTaxAmt,
    required this.totalFeeAmt,
    required this.totalBaseAmt,
  });

  AdvancedPricingSegment copyWith({
    String? fromAirport,
    String? toAirport,
    List<AdvancedPricing>? advancedPricingList,
    double? totalTaxAmt,
    double? totalFeeAmt,
    double? totalBaseAmt,
  }) {
    return AdvancedPricingSegment(
      fromAirport: fromAirport ?? this.fromAirport,
      toAirport: toAirport ?? this.toAirport,
      advancedPricingList: advancedPricingList ?? this.advancedPricingList,
      totalTaxAmt: totalTaxAmt ?? this.totalTaxAmt,
      totalFeeAmt: totalFeeAmt ?? this.totalFeeAmt,
      totalBaseAmt: totalBaseAmt ?? this.totalBaseAmt,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(fromAirport != null){
      result.addAll({'fromAirport': fromAirport});
    }
    if(toAirport != null){
      result.addAll({'toAirport': toAirport});
    }
    result.addAll({'advancedPricingList': advancedPricingList.map((x) => x.toMap()).toList()});
    result.addAll({'totalTaxAmt': totalTaxAmt});
    result.addAll({'totalFeeAmt': totalFeeAmt});
    result.addAll({'totalBaseAmt': totalBaseAmt});
  
    return result;
  }

  factory AdvancedPricingSegment.fromMap(Map<String, dynamic> map) {
    return AdvancedPricingSegment(
      fromAirport: map['fromAirport'],
      toAirport: map['toAirport'],
      advancedPricingList: List<AdvancedPricing>.from(map['advancedPricingList']?.map((x) => AdvancedPricing.fromMap(x))),
      totalTaxAmt: map['totalTaxAmt']?.toDouble() ?? 0.0,
      totalFeeAmt: map['totalFeeAmt']?.toDouble() ?? 0.0,
      totalBaseAmt: map['totalBaseAmt']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory AdvancedPricingSegment.fromJson(String source) => AdvancedPricingSegment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AdvancedPricingSegment(fromAirport: $fromAirport, toAirport: $toAirport, advancedPricingList: $advancedPricingList, totalTaxAmt: $totalTaxAmt, totalFeeAmt: $totalFeeAmt, totalBaseAmt: $totalBaseAmt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AdvancedPricingSegment &&
      other.fromAirport == fromAirport &&
      other.toAirport == toAirport &&
      listEquals(other.advancedPricingList, advancedPricingList) &&
      other.totalTaxAmt == totalTaxAmt &&
      other.totalFeeAmt == totalFeeAmt &&
      other.totalBaseAmt == totalBaseAmt;
  }

  @override
  int get hashCode {
    return fromAirport.hashCode ^
      toAirport.hashCode ^
      advancedPricingList.hashCode ^
      totalTaxAmt.hashCode ^
      totalFeeAmt.hashCode ^
      totalBaseAmt.hashCode;
  }
}
