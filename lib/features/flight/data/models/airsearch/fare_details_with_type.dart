import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/base_fare_details.dart';
import 'package:yellow_rose/features/flight/data/models/commercial_data.dart';

class FareDetailsWithType {
  final String fareType;
  final String? fareTypeDisplay;
  final String? source;
  final bool refundable;
  final bool corporateFare;
  final CommercialData? commercialData;
  final bool hasFreeMeal;
  final double baseFare;
  final double finalTax;
  final String? supplier;
  final double netFare;
  final double incentiveAmt;
  final double incentiveTds;
  final Map<String, Object>? miscellaneousData;
  final Map<String, List<double>>? taxes;
  final Map<String, Object>? otherData;
  final double surCharge;
  FareDetailsWithType({
    required this.fareType,
    this.fareTypeDisplay,
    this.source,
    this.refundable = false,
    this.corporateFare = false,
    this.commercialData,
    this.hasFreeMeal = false,
    this.baseFare = 0,
    this.finalTax = 0,
    this.supplier,
    required this.netFare,
    required this.incentiveAmt,
    required this.incentiveTds,
    this.miscellaneousData,
    this.taxes,
    this.otherData,
    required this.surCharge,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'fareType': fareType});
    if(fareTypeDisplay != null){
      result.addAll({'fareTypeDisplay': fareTypeDisplay});
    }
    if(source != null){
      result.addAll({'source': source});
    }
    result.addAll({'refundable': refundable});
    result.addAll({'corporateFare': corporateFare});
    if(commercialData != null){
      result.addAll({'commercialData': commercialData!.toMap()});
    }
    result.addAll({'hasFreeMeal': hasFreeMeal});
    result.addAll({'baseFare': baseFare});
    result.addAll({'finalTax': finalTax});
    if(supplier != null){
      result.addAll({'supplier': supplier});
    }
    result.addAll({'netFare': netFare});
    result.addAll({'incentiveAmt': incentiveAmt});
    result.addAll({'incentiveTds': incentiveTds});
    if(miscellaneousData != null){
      result.addAll({'miscellaneousData': miscellaneousData});
    }
    if(taxes != null){
      result.addAll({'taxes': taxes});
    }
    if(otherData != null){
      result.addAll({'otherData': otherData});
    }
    result.addAll({'surCharge': surCharge});
  
    return result;
  }

  factory FareDetailsWithType.fromMap(Map<String, dynamic> map) {
    return FareDetailsWithType(
      fareType: map['fareType'] ?? '',
      fareTypeDisplay: map['fareTypeDisplay'],
      source: map['source'],
      refundable: map['refundable'] ?? false,
      corporateFare: map['corporateFare'] ?? false,
      commercialData: map['commercialData'] != null ? CommercialData.fromMap(map['commercialData']) : null,
      hasFreeMeal: map['hasFreeMeal'] ?? false,
      baseFare: map['baseFare']?.toDouble() ?? 0.0,
      finalTax: map['finalTax']?.toDouble() ?? 0.0,
      supplier: map['supplier'],
      netFare: map['netFare']?.toDouble() ?? 0.0,
      incentiveAmt: map['incentiveAmt']?.toDouble() ?? 0.0,
      incentiveTds: map['incentiveTds']?.toDouble() ?? 0.0,
      miscellaneousData:map['miscellaneousData']!=null? Map<String, Object>.from(map['miscellaneousData']):null,
      taxes:map['taxes']!=null? (map['taxes'] as Map).map<String, List<double>>(
              (key, value) => MapEntry(
                key.toString(), // Ensure key is a String
                (value as List).map((e) => (e as num).toDouble()).toList(),
              ),
            )
          :null,
      otherData:map['otherData']!=null? Map<String, Object>.from(map['otherData']):null,
      surCharge: map['surCharge']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory FareDetailsWithType.fromJson(String source) =>
      FareDetailsWithType.fromMap(json.decode(source));

  double get totalCost {
    return baseFare + finalTax;
  }

  FareDetailsWithType copyWith({
    String? fareType,
    String? fareTypeDisplay,
    String? source,
    bool? refundable,
    bool? corporateFare,
    CommercialData? commercialData,
    bool? hasFreeMeal,
    double? baseFare,
    double? finalTax,
    String? supplier,
    double? netFare,
    double? incentiveAmt,
    double? incentiveTds,
    Map<String, Object>? miscellaneousData,
    Map<String, List<double>>? taxes,
    Map<String, Object>? otherData,
    double? surCharge,
  }) {
    return FareDetailsWithType(
      fareType: fareType ?? this.fareType,
      fareTypeDisplay: fareTypeDisplay ?? this.fareTypeDisplay,
      source: source ?? this.source,
      refundable: refundable ?? this.refundable,
      corporateFare: corporateFare ?? this.corporateFare,
      commercialData: commercialData ?? this.commercialData,
      hasFreeMeal: hasFreeMeal ?? this.hasFreeMeal,
      baseFare: baseFare ?? this.baseFare,
      finalTax: finalTax ?? this.finalTax,
      supplier: supplier ?? this.supplier,
      netFare: netFare ?? this.netFare,
      incentiveAmt: incentiveAmt ?? this.incentiveAmt,
      incentiveTds: incentiveTds ?? this.incentiveTds,
      miscellaneousData: miscellaneousData ?? this.miscellaneousData,
      taxes: taxes ?? this.taxes,
      otherData: otherData ?? this.otherData,
      surCharge: surCharge ?? this.surCharge,
    );
  }

  @override
  String toString() {
    return 'FareDetailsWithType(fareType: $fareType, fareTypeDisplay: $fareTypeDisplay, source: $source, refundable: $refundable, corporateFare: $corporateFare, commercialData: $commercialData, hasFreeMeal: $hasFreeMeal, baseFare: $baseFare, finalTax: $finalTax, supplier: $supplier, netFare: $netFare, incentiveAmt: $incentiveAmt, incentiveTds: $incentiveTds, miscellaneousData: $miscellaneousData, taxes: $taxes, otherData: $otherData, surCharge: $surCharge)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FareDetailsWithType &&
      other.fareType == fareType &&
      other.fareTypeDisplay == fareTypeDisplay &&
      other.source == source &&
      other.refundable == refundable &&
      other.corporateFare == corporateFare &&
      other.commercialData == commercialData &&
      other.hasFreeMeal == hasFreeMeal &&
      other.baseFare == baseFare &&
      other.finalTax == finalTax &&
      other.supplier == supplier &&
      other.netFare == netFare &&
      other.incentiveAmt == incentiveAmt &&
      other.incentiveTds == incentiveTds &&
      mapEquals(other.miscellaneousData, miscellaneousData) &&
      mapEquals(other.taxes, taxes) &&
      mapEquals(other.otherData, otherData) &&
      other.surCharge == surCharge;
  }

  @override
  int get hashCode {
    return fareType.hashCode ^
      fareTypeDisplay.hashCode ^
      source.hashCode ^
      refundable.hashCode ^
      corporateFare.hashCode ^
      commercialData.hashCode ^
      hasFreeMeal.hashCode ^
      baseFare.hashCode ^
      finalTax.hashCode ^
      supplier.hashCode ^
      netFare.hashCode ^
      incentiveAmt.hashCode ^
      incentiveTds.hashCode ^
      miscellaneousData.hashCode ^
      taxes.hashCode ^
      otherData.hashCode ^
      surCharge.hashCode;
  }
}
