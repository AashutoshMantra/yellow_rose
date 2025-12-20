import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/mmt/mmt_tax_break_up.dart';

class MMTHotelSearchResPrice {
  final int? totalRoomCount;
  final double? basePrice;
  final String displayPriceType;
  final double? totalTax;
  final bool? taxIncluded;
  final double? couponDiscount;
  final double? hotelDiscount;
  final List<String>? applicableCoupons;
  final MMTHotelSearchResTaxBreakup? taxBreakUp;
  final String? couponCode;
  MMTHotelSearchResPrice({
    this.totalRoomCount,
    this.basePrice,
    required this.displayPriceType,
    this.totalTax,
    this.taxIncluded,
    this.couponDiscount,
    this.hotelDiscount,
    this.applicableCoupons,
    this.taxBreakUp,
    this.couponCode,
  });

  MMTHotelSearchResPrice copyWith({
    int? totalRoomCount,
    double? basePrice,
    String? displayPriceType,
    double? totalTax,
    bool? taxIncluded,
    double? couponDiscount,
    double? hotelDiscount,
    List<String>? applicableCoupons,
    MMTHotelSearchResTaxBreakup? taxBreakUp,
    String? couponCode,
  }) {
    return MMTHotelSearchResPrice(
      totalRoomCount: totalRoomCount ?? this.totalRoomCount,
      basePrice: basePrice ?? this.basePrice,
      displayPriceType: displayPriceType ?? this.displayPriceType,
      totalTax: totalTax ?? this.totalTax,
      taxIncluded: taxIncluded ?? this.taxIncluded,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      hotelDiscount: hotelDiscount ?? this.hotelDiscount,
      applicableCoupons: applicableCoupons ?? this.applicableCoupons,
      taxBreakUp: taxBreakUp ?? this.taxBreakUp,
      couponCode: couponCode ?? this.couponCode,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (totalRoomCount != null) {
      result.addAll({'totalRoomCount': totalRoomCount});
    }
    if (basePrice != null) {
      result.addAll({'basePrice': basePrice});
    }
    result.addAll({'displayPriceType': displayPriceType});
    if (totalTax != null) {
      result.addAll({'totalTax': totalTax});
    }
    if (taxIncluded != null) {
      result.addAll({'taxIncluded': taxIncluded});
    }
    if (couponDiscount != null) {
      result.addAll({'couponDiscount': couponDiscount});
    }
    if (hotelDiscount != null) {
      result.addAll({'hotelDiscount': hotelDiscount});
    }
    if (applicableCoupons != null) {
      result.addAll({'applicableCoupons': applicableCoupons});
    }
    if (taxBreakUp != null) {
      result.addAll({'taxBreakUp': taxBreakUp!.toMap()});
    }
    if (couponCode != null) {
      result.addAll({'couponCode': couponCode});
    }

    return result;
  }

  factory MMTHotelSearchResPrice.fromMap(Map<String, dynamic> map) {
    return MMTHotelSearchResPrice(
      totalRoomCount: map['totalRoomCount'] is String
          ? int.tryParse(map['totalRoomCount'])
          : map['totalRoomCount'],
      basePrice: map['basePrice']?.toDouble(),
      displayPriceType: map['displayPriceType'] ?? '',
      totalTax: map['totalTax']?.toDouble(),
      taxIncluded: map['taxIncluded'],
      couponDiscount: map['couponDiscount']?.toDouble(),
      hotelDiscount: map['hotelDiscount']?.toDouble(),
      applicableCoupons: List<String>.from(map['applicableCoupons']),
      taxBreakUp: map['taxBreakUp'] != null
          ? MMTHotelSearchResTaxBreakup.fromMap(map['taxBreakUp'])
          : null,
      couponCode: map['couponCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MMTHotelSearchResPrice.fromJson(String source) =>
      MMTHotelSearchResPrice.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MMTHotelSearchResPrice(totalRoomCount: $totalRoomCount, basePrice: $basePrice, displayPriceType: $displayPriceType, totalTax: $totalTax, taxIncluded: $taxIncluded, couponDiscount: $couponDiscount, hotelDiscount: $hotelDiscount, applicableCoupons: $applicableCoupons, taxBreakUp: $taxBreakUp, couponCode: $couponCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MMTHotelSearchResPrice &&
        other.totalRoomCount == totalRoomCount &&
        other.basePrice == basePrice &&
        other.displayPriceType == displayPriceType &&
        other.totalTax == totalTax &&
        other.taxIncluded == taxIncluded &&
        other.couponDiscount == couponDiscount &&
        other.hotelDiscount == hotelDiscount &&
        listEquals(other.applicableCoupons, applicableCoupons) &&
        other.taxBreakUp == taxBreakUp &&
        other.couponCode == couponCode;
  }

  @override
  int get hashCode {
    return totalRoomCount.hashCode ^
        basePrice.hashCode ^
        displayPriceType.hashCode ^
        totalTax.hashCode ^
        taxIncluded.hashCode ^
        couponDiscount.hashCode ^
        hotelDiscount.hashCode ^
        applicableCoupons.hashCode ^
        taxBreakUp.hashCode ^
        couponCode.hashCode;
  }
}
