import 'dart:convert';

import 'package:yellow_rose/features/bus/data/models/search/red_bus_comercial.dart';

class BusFare {
  final double? baseFare;
  final double? gst;
  final double? serviceTax;
  final double? totalFare;
  final double? levyFare;
  final double? markupFareAbsolute;
  final double? markupFarePercentage;
  final double? opFare;
  final double? opGroupFare;
  final double? operatorServiceChargeAbsolute;
  final double? operatorServiceChargePercentage;
  final double? tollFee;
  final double? srtFee;
  final double? childFare;
  final double? bankTrexAmt;
  final RedbusCommercial? commercialData;
  BusFare({
    this.baseFare,
    this.gst,
    this.serviceTax,
    this.totalFare,
    this.levyFare,
    this.markupFareAbsolute,
    this.markupFarePercentage,
    this.opFare,
    this.opGroupFare,
    this.operatorServiceChargeAbsolute,
    this.operatorServiceChargePercentage,
    this.tollFee,
    this.srtFee,
    this.childFare,
    this.bankTrexAmt,
    this.commercialData,
  });

  BusFare copyWith({
    double? baseFare,
    double? gst,
    double? serviceTax,
    double? totalFare,
    double? levyFare,
    double? markupFareAbsolute,
    double? markupFarePercentage,
    double? opFare,
    double? opGroupFare,
    double? operatorServiceChargeAbsolute,
    double? operatorServiceChargePercentage,
    double? tollFee,
    double? srtFee,
    double? childFare,
    double? bankTrexAmt,
    RedbusCommercial? commercialData,
  }) {
    return BusFare(
      baseFare: baseFare ?? this.baseFare,
      gst: gst ?? this.gst,
      serviceTax: serviceTax ?? this.serviceTax,
      totalFare: totalFare ?? this.totalFare,
      levyFare: levyFare ?? this.levyFare,
      markupFareAbsolute: markupFareAbsolute ?? this.markupFareAbsolute,
      markupFarePercentage: markupFarePercentage ?? this.markupFarePercentage,
      opFare: opFare ?? this.opFare,
      opGroupFare: opGroupFare ?? this.opGroupFare,
      operatorServiceChargeAbsolute: operatorServiceChargeAbsolute ?? this.operatorServiceChargeAbsolute,
      operatorServiceChargePercentage: operatorServiceChargePercentage ?? this.operatorServiceChargePercentage,
      tollFee: tollFee ?? this.tollFee,
      srtFee: srtFee ?? this.srtFee,
      childFare: childFare ?? this.childFare,
      bankTrexAmt: bankTrexAmt ?? this.bankTrexAmt,
      commercialData: commercialData ?? this.commercialData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(baseFare != null){
      result.addAll({'baseFare': baseFare});
    }
    if(gst != null){
      result.addAll({'gst': gst});
    }
    if(serviceTax != null){
      result.addAll({'serviceTax': serviceTax});
    }
    if(totalFare != null){
      result.addAll({'totalFare': totalFare});
    }
    if(levyFare != null){
      result.addAll({'levyFare': levyFare});
    }
    if(markupFareAbsolute != null){
      result.addAll({'markupFareAbsolute': markupFareAbsolute});
    }
    if(markupFarePercentage != null){
      result.addAll({'markupFarePercentage': markupFarePercentage});
    }
    if(opFare != null){
      result.addAll({'opFare': opFare});
    }
    if(opGroupFare != null){
      result.addAll({'opGroupFare': opGroupFare});
    }
    if(operatorServiceChargeAbsolute != null){
      result.addAll({'operatorServiceChargeAbsolute': operatorServiceChargeAbsolute});
    }
    if(operatorServiceChargePercentage != null){
      result.addAll({'operatorServiceChargePercentage': operatorServiceChargePercentage});
    }
    if(tollFee != null){
      result.addAll({'tollFee': tollFee});
    }
    if(srtFee != null){
      result.addAll({'srtFee': srtFee});
    }
    if(childFare != null){
      result.addAll({'childFare': childFare});
    }
    if(bankTrexAmt != null){
      result.addAll({'bankTrexAmt': bankTrexAmt});
    }
    if(commercialData != null){
      result.addAll({'commercialData': commercialData!.toMap()});
    }
  
    return result;
  }

  factory BusFare.fromMap(Map<String, dynamic> map) {
    return BusFare(
      baseFare: map['baseFare']?.toDouble(),
      gst: map['gst']?.toDouble(),
      serviceTax: map['serviceTax']?.toDouble(),
      totalFare: map['totalFare']?.toDouble(),
      levyFare: map['levyFare']?.toDouble(),
      markupFareAbsolute: map['markupFareAbsolute']?.toDouble(),
      markupFarePercentage: map['markupFarePercentage']?.toDouble(),
      opFare: map['opFare']?.toDouble(),
      opGroupFare: map['opGroupFare']?.toDouble(),
      operatorServiceChargeAbsolute: map['operatorServiceChargeAbsolute']?.toDouble(),
      operatorServiceChargePercentage: map['operatorServiceChargePercentage']?.toDouble(),
      tollFee: map['tollFee']?.toDouble(),
      srtFee: map['srtFee']?.toDouble(),
      childFare: map['childFare']?.toDouble(),
      bankTrexAmt: map['bankTrexAmt']?.toDouble(),
      commercialData: map['commercialData'] != null ? RedbusCommercial.fromMap(map['commercialData']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusFare.fromJson(String source) => BusFare.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusFare(baseFare: $baseFare, gst: $gst, serviceTax: $serviceTax, totalFare: $totalFare, levyFare: $levyFare, markupFareAbsolute: $markupFareAbsolute, markupFarePercentage: $markupFarePercentage, opFare: $opFare, opGroupFare: $opGroupFare, operatorServiceChargeAbsolute: $operatorServiceChargeAbsolute, operatorServiceChargePercentage: $operatorServiceChargePercentage, tollFee: $tollFee, srtFee: $srtFee, childFare: $childFare, bankTrexAmt: $bankTrexAmt, commercialData: $commercialData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is BusFare &&
      other.baseFare == baseFare &&
      other.gst == gst &&
      other.serviceTax == serviceTax &&
      other.totalFare == totalFare &&
      other.levyFare == levyFare &&
      other.markupFareAbsolute == markupFareAbsolute &&
      other.markupFarePercentage == markupFarePercentage &&
      other.opFare == opFare &&
      other.opGroupFare == opGroupFare &&
      other.operatorServiceChargeAbsolute == operatorServiceChargeAbsolute &&
      other.operatorServiceChargePercentage == operatorServiceChargePercentage &&
      other.tollFee == tollFee &&
      other.srtFee == srtFee &&
      other.childFare == childFare &&
      other.bankTrexAmt == bankTrexAmt &&
      other.commercialData == commercialData;
  }

  @override
  int get hashCode {
    return baseFare.hashCode ^
      gst.hashCode ^
      serviceTax.hashCode ^
      totalFare.hashCode ^
      levyFare.hashCode ^
      markupFareAbsolute.hashCode ^
      markupFarePercentage.hashCode ^
      opFare.hashCode ^
      opGroupFare.hashCode ^
      operatorServiceChargeAbsolute.hashCode ^
      operatorServiceChargePercentage.hashCode ^
      tollFee.hashCode ^
      srtFee.hashCode ^
      childFare.hashCode ^
      bankTrexAmt.hashCode ^
      commercialData.hashCode;
  }
}
