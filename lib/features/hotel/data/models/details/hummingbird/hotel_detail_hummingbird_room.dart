import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/hotel_detail_commercial.dart';

class HotelDetailHummingbirdRoom {
  final String? name;
  final String? roomTypeCode;
  final String? ratePlanCode;
  final double? tariff;
  final bool? taxInclusive;
  final double? taxPercentage;
  final double? taxAmount;
  final String? currency;
  final String? inclusion;
  final String? mealPlan;
  final int? maxOccupancy;
  final String? roomImage;
  final String? cancellationPolicy;
  final String? freeCancellationUntil;
  final String? cancellationPenalty;
  final bool? breakfastIncluded;
  final bool? corporateRate;
  final bool? instantBooking;
  final double? roomBasePrice;
  final double? tax;
  final double? exclusivePrice;
  final double? inclusivePrice;
  final double? inclusivePriceWithRoot;
  final HotelDetailCommercial? commercial;
  final double? totalAmount;
  HotelDetailHummingbirdRoom({
    this.name,
    this.roomTypeCode,
    this.ratePlanCode,
    this.tariff,
    this.taxInclusive,
    this.taxPercentage,
    this.taxAmount,
    this.currency,
    this.inclusion,
    this.mealPlan,
    this.maxOccupancy,
    this.roomImage,
    this.cancellationPolicy,
    this.freeCancellationUntil,
    this.cancellationPenalty,
    this.breakfastIncluded,
    this.corporateRate,
    this.instantBooking,
    this.roomBasePrice,
    this.tax,
    this.exclusivePrice,
    this.inclusivePrice,
    this.inclusivePriceWithRoot,
    this.commercial,
    this.totalAmount,
  });

  HotelDetailHummingbirdRoom copyWith({
    String? name,
    String? roomTypeCode,
    String? ratePlanCode,
    double? tariff,
    bool? taxInclusive,
    double? taxPercentage,
    double? taxAmount,
    String? currency,
    String? inclusion,
    String? mealPlan,
    int? maxOccupancy,
    String? roomImage,
    String? cancellationPolicy,
    String? freeCancellationUntil,
    String? cancellationPenalty,
    bool? breakfastIncluded,
    bool? corporateRate,
    bool? instantBooking,
    double? roomBasePrice,
    double? tax,
    double? exclusivePrice,
    double? inclusivePrice,
    double? inclusivePriceWithRoot,
    HotelDetailCommercial? commercial,
    double? totalAmount,
  }) {
    return HotelDetailHummingbirdRoom(
      name: name ?? this.name,
      roomTypeCode: roomTypeCode ?? this.roomTypeCode,
      ratePlanCode: ratePlanCode ?? this.ratePlanCode,
      tariff: tariff ?? this.tariff,
      taxInclusive: taxInclusive ?? this.taxInclusive,
      taxPercentage: taxPercentage ?? this.taxPercentage,
      taxAmount: taxAmount ?? this.taxAmount,
      currency: currency ?? this.currency,
      inclusion: inclusion ?? this.inclusion,
      mealPlan: mealPlan ?? this.mealPlan,
      maxOccupancy: maxOccupancy ?? this.maxOccupancy,
      roomImage: roomImage ?? this.roomImage,
      cancellationPolicy: cancellationPolicy ?? this.cancellationPolicy,
      freeCancellationUntil:
          freeCancellationUntil ?? this.freeCancellationUntil,
      cancellationPenalty: cancellationPenalty ?? this.cancellationPenalty,
      breakfastIncluded: breakfastIncluded ?? this.breakfastIncluded,
      corporateRate: corporateRate ?? this.corporateRate,
      instantBooking: instantBooking ?? this.instantBooking,
      roomBasePrice: roomBasePrice ?? this.roomBasePrice,
      tax: tax ?? this.tax,
      exclusivePrice: exclusivePrice ?? this.exclusivePrice,
      inclusivePrice: inclusivePrice ?? this.inclusivePrice,
      inclusivePriceWithRoot:
          inclusivePriceWithRoot ?? this.inclusivePriceWithRoot,
      commercial: commercial ?? this.commercial,
      totalAmount: totalAmount ?? this.totalAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (roomTypeCode != null) {
      result.addAll({'roomTypeCode': roomTypeCode});
    }
    if (ratePlanCode != null) {
      result.addAll({'ratePlanCode': ratePlanCode});
    }
    if (tariff != null) {
      result.addAll({'tariff': tariff});
    }
    if (taxInclusive != null) {
      result.addAll({'taxInclusive': taxInclusive});
    }
    if (taxPercentage != null) {
      result.addAll({'taxPercentage': taxPercentage});
    }
    if (taxAmount != null) {
      result.addAll({'taxAmount': taxAmount});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (inclusion != null) {
      result.addAll({'inclusion': inclusion});
    }
    if (mealPlan != null) {
      result.addAll({'mealPlan': mealPlan});
    }
    if (maxOccupancy != null) {
      result.addAll({'maxOccupancy': maxOccupancy});
    }
    if (roomImage != null) {
      result.addAll({'roomImage': roomImage});
    }
    if (cancellationPolicy != null) {
      result.addAll({'cancellationPolicy': cancellationPolicy});
    }
    if (freeCancellationUntil != null) {
      result.addAll({'freeCancellationUntil': freeCancellationUntil});
    }
    if (cancellationPenalty != null) {
      result.addAll({'cancellationPenalty': cancellationPenalty});
    }
    if (breakfastIncluded != null) {
      result.addAll({'breakfastIncluded': breakfastIncluded});
    }
    if (corporateRate != null) {
      result.addAll({'corporateRate': corporateRate});
    }
    if (instantBooking != null) {
      result.addAll({'instantBooking': instantBooking});
    }
    if (roomBasePrice != null) {
      result.addAll({'roomBasePrice': roomBasePrice});
    }
    if (tax != null) {
      result.addAll({'tax': tax});
    }
    if (exclusivePrice != null) {
      result.addAll({'exclusivePrice': exclusivePrice});
    }
    if (inclusivePrice != null) {
      result.addAll({'inclusivePrice': inclusivePrice});
    }
    if (inclusivePriceWithRoot != null) {
      result.addAll({'inclusivePriceWithRoot': inclusivePriceWithRoot});
    }
    if (commercial != null) {
      result.addAll({'commercial': commercial!.toMap()});
    }
    if (totalAmount != null) {
      result.addAll({'totalAmount': totalAmount});
    }

    return result;
  }

  factory HotelDetailHummingbirdRoom.fromMap(Map<String, dynamic> map) {
    return HotelDetailHummingbirdRoom(
      name: map['name'],
      roomTypeCode: map['roomTypeCode']?.toString(),
      ratePlanCode: map['ratePlanCode']?.toString(),
      tariff: map['tariff']?.toDouble(),
      taxInclusive: map['taxInclusive'],
      taxPercentage: map['taxPercentage']?.toDouble(),
      taxAmount: map['taxAmount']?.toDouble(),
      currency: map['currency'],
      inclusion: map['inclusion'],
      mealPlan: map['mealPlan'],
      maxOccupancy: map['maxOccupancy']?.toInt(),
      roomImage: map['roomImage'],
      cancellationPolicy: map['cancellationPolicy'],
      freeCancellationUntil: map['freeCancellationUntil'],
      cancellationPenalty: map['cancellationPenalty']?.toString(),
      breakfastIncluded: map['breakfastIncluded'],
      corporateRate: map['corporateRate'],
      instantBooking: map['instantBooking'],
      roomBasePrice: map['roomBasePrice']?.toDouble(),
      tax: map['tax']?.toDouble(),
      exclusivePrice: map['exclusivePrice']?.toDouble(),
      inclusivePrice: map['inclusivePrice']?.toDouble(),
      inclusivePriceWithRoot: map['inclusivePriceWithRoot']?.toDouble(),
      commercial: map['commercial'] != null
          ? HotelDetailCommercial.fromMap(map['commercial'])
          : null,
      totalAmount: map['totalAmount']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelDetailHummingbirdRoom.fromJson(String source) =>
      HotelDetailHummingbirdRoom.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelDetailHummingbirdRoom(name: $name, roomTypeCode: $roomTypeCode, ratePlanCode: $ratePlanCode, tariff: $tariff, taxInclusive: $taxInclusive, taxPercentage: $taxPercentage, taxAmount: $taxAmount, currency: $currency, inclusion: $inclusion, mealPlan: $mealPlan, maxOccupancy: $maxOccupancy, roomImage: $roomImage, cancellationPolicy: $cancellationPolicy, freeCancellationUntil: $freeCancellationUntil, cancellationPenalty: $cancellationPenalty, breakfastIncluded: $breakfastIncluded, corporateRate: $corporateRate, instantBooking: $instantBooking, roomBasePrice: $roomBasePrice, tax: $tax, exclusivePrice: $exclusivePrice, inclusivePrice: $inclusivePrice, inclusivePriceWithRoot: $inclusivePriceWithRoot, commercial: $commercial, totalAmount: $totalAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelDetailHummingbirdRoom &&
        other.name == name &&
        other.roomTypeCode == roomTypeCode &&
        other.ratePlanCode == ratePlanCode &&
        other.tariff == tariff &&
        other.taxInclusive == taxInclusive &&
        other.taxPercentage == taxPercentage &&
        other.taxAmount == taxAmount &&
        other.currency == currency &&
        other.inclusion == inclusion &&
        other.mealPlan == mealPlan &&
        other.maxOccupancy == maxOccupancy &&
        other.roomImage == roomImage &&
        other.cancellationPolicy == cancellationPolicy &&
        other.freeCancellationUntil == freeCancellationUntil &&
        other.cancellationPenalty == cancellationPenalty &&
        other.breakfastIncluded == breakfastIncluded &&
        other.corporateRate == corporateRate &&
        other.instantBooking == instantBooking &&
        other.roomBasePrice == roomBasePrice &&
        other.tax == tax &&
        other.exclusivePrice == exclusivePrice &&
        other.inclusivePrice == inclusivePrice &&
        other.inclusivePriceWithRoot == inclusivePriceWithRoot &&
        other.commercial == commercial &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        roomTypeCode.hashCode ^
        ratePlanCode.hashCode ^
        tariff.hashCode ^
        taxInclusive.hashCode ^
        taxPercentage.hashCode ^
        taxAmount.hashCode ^
        currency.hashCode ^
        inclusion.hashCode ^
        mealPlan.hashCode ^
        maxOccupancy.hashCode ^
        roomImage.hashCode ^
        cancellationPolicy.hashCode ^
        freeCancellationUntil.hashCode ^
        cancellationPenalty.hashCode ^
        breakfastIncluded.hashCode ^
        corporateRate.hashCode ^
        instantBooking.hashCode ^
        roomBasePrice.hashCode ^
        tax.hashCode ^
        exclusivePrice.hashCode ^
        inclusivePrice.hashCode ^
        inclusivePriceWithRoot.hashCode ^
        commercial.hashCode ^
        totalAmount.hashCode;
  }
}
