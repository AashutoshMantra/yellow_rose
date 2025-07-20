import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/flight/data/models/booking/order/update_order_detail_response.dart';

class CustomerPayment {
  final PaxRescheduleCharges? paxRescheduleCharges;
  final double mealCharges;
  final double seatCharges;
  final double baggageSSRCharges;
  final double specialSSRCharges;
  final double preferenceCharges;
  final double incentiveAmt;
  final double incentiveTds;
  final double insurance;
  final double totalBookingAmount;
  final double totalBaseAmount;
  final double airlineTaxes;
  final double finalTaxes;
  final double couponDiscount;
  final double hotelDiscount;
  final double totalDiscount;
  final double propertyFee;
  final double salesTaxes;
  final String? couponCode;
  final String? currency;
  final Map<String, Object>? commissionData;
  final Map<String, Object>? markupData;
  final Map<String, Object>? miscPriceData;
  CustomerPayment({
    this.paxRescheduleCharges,
    required this.mealCharges,
    required this.seatCharges,
    required this.baggageSSRCharges,
    required this.specialSSRCharges,
    required this.preferenceCharges,
    required this.incentiveAmt,
    required this.incentiveTds,
    required this.insurance,
    required this.totalBookingAmount,
    required this.totalBaseAmount,
    required this.airlineTaxes,
    required this.finalTaxes,
    required this.couponDiscount,
    required this.hotelDiscount,
    required this.totalDiscount,
    required this.propertyFee,
    required this.salesTaxes,
    this.couponCode,
    this.currency,
    this.commissionData,
    this.markupData,
    this.miscPriceData,
  });

  CustomerPayment copyWith({
    PaxRescheduleCharges? paxRescheduleCharges,
    double? mealCharges,
    double? seatCharges,
    double? baggageSSRCharges,
    double? specialSSRCharges,
    double? preferenceCharges,
    double? incentiveAmt,
    double? incentiveTds,
    double? insurance,
    double? totalBookingAmount,
    double? totalBaseAmount,
    double? airlineTaxes,
    double? finalTaxes,
    double? couponDiscount,
    double? hotelDiscount,
    double? totalDiscount,
    double? propertyFee,
    double? salesTaxes,
    String? couponCode,
    String? currency,
    Map<String, Object>? commissionData,
    Map<String, Object>? markupData,
    Map<String, Object>? miscPriceData,
  }) {
    return CustomerPayment(
      paxRescheduleCharges: paxRescheduleCharges ?? this.paxRescheduleCharges,
      mealCharges: mealCharges ?? this.mealCharges,
      seatCharges: seatCharges ?? this.seatCharges,
      baggageSSRCharges: baggageSSRCharges ?? this.baggageSSRCharges,
      specialSSRCharges: specialSSRCharges ?? this.specialSSRCharges,
      preferenceCharges: preferenceCharges ?? this.preferenceCharges,
      incentiveAmt: incentiveAmt ?? this.incentiveAmt,
      incentiveTds: incentiveTds ?? this.incentiveTds,
      insurance: insurance ?? this.insurance,
      totalBookingAmount: totalBookingAmount ?? this.totalBookingAmount,
      totalBaseAmount: totalBaseAmount ?? this.totalBaseAmount,
      airlineTaxes: airlineTaxes ?? this.airlineTaxes,
      finalTaxes: finalTaxes ?? this.finalTaxes,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      hotelDiscount: hotelDiscount ?? this.hotelDiscount,
      totalDiscount: totalDiscount ?? this.totalDiscount,
      propertyFee: propertyFee ?? this.propertyFee,
      salesTaxes: salesTaxes ?? this.salesTaxes,
      couponCode: couponCode ?? this.couponCode,
      currency: currency ?? this.currency,
      commissionData: commissionData ?? this.commissionData,
      markupData: markupData ?? this.markupData,
      miscPriceData: miscPriceData ?? this.miscPriceData,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (paxRescheduleCharges != null) {
      result.addAll({'paxRescheduleCharges': paxRescheduleCharges!.toMap()});
    }
    result.addAll({'mealCharges': mealCharges});
    result.addAll({'seatCharges': seatCharges});
    result.addAll({'baggageSSRCharges': baggageSSRCharges});
    result.addAll({'specialSSRCharges': specialSSRCharges});
    result.addAll({'preferenceCharges': preferenceCharges});
    result.addAll({'incentiveAmt': incentiveAmt});
    result.addAll({'incentiveTds': incentiveTds});
    result.addAll({'insurance': insurance});
    result.addAll({'totalBookingAmount': totalBookingAmount});
    result.addAll({'totalBaseAmount': totalBaseAmount});
    result.addAll({'airlineTaxes': airlineTaxes});
    result.addAll({'finalTaxes': finalTaxes});
    result.addAll({'couponDiscount': couponDiscount});
    result.addAll({'hotelDiscount': hotelDiscount});
    result.addAll({'totalDiscount': totalDiscount});
    result.addAll({'propertyFee': propertyFee});
    result.addAll({'salesTaxes': salesTaxes});
    if (couponCode != null) {
      result.addAll({'couponCode': couponCode});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (commissionData != null) {
      result.addAll({'commissionData': commissionData});
    }
    if (markupData != null) {
      result.addAll({'markupData': markupData});
    }
    if (miscPriceData != null) {
      result.addAll({'miscPriceData': miscPriceData});
    }

    return result;
  }

  factory CustomerPayment.fromMap(Map<String, dynamic> map) {
    return CustomerPayment(
      paxRescheduleCharges: map['paxRescheduleCharges'] != null
          ? PaxRescheduleCharges.fromMap(map['paxRescheduleCharges'])
          : null,
      mealCharges: map['mealCharges']?.toDouble() ?? 0.0,
      seatCharges: map['seatCharges']?.toDouble() ?? 0.0,
      baggageSSRCharges: map['baggageSSRCharges']?.toDouble() ?? 0.0,
      specialSSRCharges: map['specialSSRCharges']?.toDouble() ?? 0.0,
      preferenceCharges: map['preferenceCharges']?.toDouble() ?? 0.0,
      incentiveAmt: map['incentiveAmt']?.toDouble() ?? 0.0,
      incentiveTds: map['incentiveTds']?.toDouble() ?? 0.0,
      insurance: map['insurance']?.toDouble() ?? 0.0,
      totalBookingAmount: map['totalBookingAmount']?.toDouble() ?? 0.0,
      totalBaseAmount: map['totalBaseAmount']?.toDouble() ?? 0.0,
      airlineTaxes: map['airlineTaxes']?.toDouble() ?? 0.0,
      finalTaxes: map['finalTaxes']?.toDouble() ?? 0.0,
      couponDiscount: map['couponDiscount']?.toDouble() ?? 0.0,
      hotelDiscount: map['hotelDiscount']?.toDouble() ?? 0.0,
      totalDiscount: map['totalDiscount']?.toDouble() ?? 0.0,
      propertyFee: map['propertyFee']?.toDouble() ?? 0.0,
      salesTaxes: map['salesTaxes']?.toDouble() ?? 0.0,
      couponCode: map['couponCode'],
      currency: map['currency'],
      commissionData: map['commissionData'] != null
          ? Map<String, Object>.from(map['commissionData'])
          : null,
      markupData: map['markupData'] != null
          ? Map<String, Object>.from(map['markupData'])
          : null,
      miscPriceData: map['miscPriceData'] != null
          ? Map<String, Object>.from(map['miscPriceData'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerPayment.fromJson(String source) =>
      CustomerPayment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerPayment(paxRescheduleCharges: $paxRescheduleCharges, mealCharges: $mealCharges, seatCharges: $seatCharges, baggageSSRCharges: $baggageSSRCharges, specialSSRCharges: $specialSSRCharges, preferenceCharges: $preferenceCharges, incentiveAmt: $incentiveAmt, incentiveTds: $incentiveTds, insurance: $insurance, totalBookingAmount: $totalBookingAmount, totalBaseAmount: $totalBaseAmount, airlineTaxes: $airlineTaxes, finalTaxes: $finalTaxes, couponDiscount: $couponDiscount, hotelDiscount: $hotelDiscount, totalDiscount: $totalDiscount, propertyFee: $propertyFee, salesTaxes: $salesTaxes, couponCode: $couponCode, currency: $currency, commissionData: $commissionData, markupData: $markupData, miscPriceData: $miscPriceData)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerPayment &&
        other.paxRescheduleCharges == paxRescheduleCharges &&
        other.mealCharges == mealCharges &&
        other.seatCharges == seatCharges &&
        other.baggageSSRCharges == baggageSSRCharges &&
        other.specialSSRCharges == specialSSRCharges &&
        other.preferenceCharges == preferenceCharges &&
        other.incentiveAmt == incentiveAmt &&
        other.incentiveTds == incentiveTds &&
        other.insurance == insurance &&
        other.totalBookingAmount == totalBookingAmount &&
        other.totalBaseAmount == totalBaseAmount &&
        other.airlineTaxes == airlineTaxes &&
        other.finalTaxes == finalTaxes &&
        other.couponDiscount == couponDiscount &&
        other.hotelDiscount == hotelDiscount &&
        other.totalDiscount == totalDiscount &&
        other.propertyFee == propertyFee &&
        other.salesTaxes == salesTaxes &&
        other.couponCode == couponCode &&
        other.currency == currency &&
        mapEquals(other.commissionData, commissionData) &&
        mapEquals(other.markupData, markupData) &&
        mapEquals(other.miscPriceData, miscPriceData);
  }

  @override
  int get hashCode {
    return paxRescheduleCharges.hashCode ^
        mealCharges.hashCode ^
        seatCharges.hashCode ^
        baggageSSRCharges.hashCode ^
        specialSSRCharges.hashCode ^
        preferenceCharges.hashCode ^
        incentiveAmt.hashCode ^
        incentiveTds.hashCode ^
        insurance.hashCode ^
        totalBookingAmount.hashCode ^
        totalBaseAmount.hashCode ^
        airlineTaxes.hashCode ^
        finalTaxes.hashCode ^
        couponDiscount.hashCode ^
        hotelDiscount.hashCode ^
        totalDiscount.hashCode ^
        propertyFee.hashCode ^
        salesTaxes.hashCode ^
        couponCode.hashCode ^
        currency.hashCode ^
        commissionData.hashCode ^
        markupData.hashCode ^
        miscPriceData.hashCode;
  }
}
