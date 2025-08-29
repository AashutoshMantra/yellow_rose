import 'dart:convert';

import 'package:flutter/foundation.dart';

class HotelSearchResRoomRate {
  final String? description;
  final String? currency;
  final double baseRate;
  final double exclusive;
  final double inclusive;
  final double tax;
  final double fees;
  final double hotelDiscount;
  final double couponDiscount;
  final String? couponCode;
  final List<String>? applicableCouponCode;
  final String? method;
  final double totalAmount;
  final double commercialAmount;
  HotelSearchResRoomRate({
    this.description,
    this.currency,
    required this.baseRate,
    required this.exclusive,
    required this.inclusive,
    required this.tax,
    required this.fees,
    required this.hotelDiscount,
    required this.couponDiscount,
    this.couponCode,
    this.applicableCouponCode,
    this.method,
    required this.totalAmount,
    required this.commercialAmount,
  });

  HotelSearchResRoomRate copyWith({
    String? description,
    String? currency,
    double? baseRate,
    double? exclusive,
    double? inclusive,
    double? tax,
    double? fees,
    double? hotelDiscount,
    double? couponDiscount,
    String? couponCode,
    List<String>? applicableCouponCode,
    String? method,
    double? totalAmount,
    double? commercialAmount,
  }) {
    return HotelSearchResRoomRate(
      description: description ?? this.description,
      currency: currency ?? this.currency,
      baseRate: baseRate ?? this.baseRate,
      exclusive: exclusive ?? this.exclusive,
      inclusive: inclusive ?? this.inclusive,
      tax: tax ?? this.tax,
      fees: fees ?? this.fees,
      hotelDiscount: hotelDiscount ?? this.hotelDiscount,
      couponDiscount: couponDiscount ?? this.couponDiscount,
      couponCode: couponCode ?? this.couponCode,
      applicableCouponCode: applicableCouponCode ?? this.applicableCouponCode,
      method: method ?? this.method,
      totalAmount: totalAmount ?? this.totalAmount,
      commercialAmount: commercialAmount ?? this.commercialAmount,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (description != null) {
      result.addAll({'description': description});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    result.addAll({'baseRate': baseRate});
    result.addAll({'exclusive': exclusive});
    result.addAll({'inclusive': inclusive});
    result.addAll({'tax': tax});
    result.addAll({'fees': fees});
    result.addAll({'hotelDiscount': hotelDiscount});
    result.addAll({'couponDiscount': couponDiscount});
    if (couponCode != null) {
      result.addAll({'couponCode': couponCode});
    }
    if (applicableCouponCode != null) {
      result.addAll({'applicableCouponCode': applicableCouponCode});
    }
    if (method != null) {
      result.addAll({'method': method});
    }
    result.addAll({'totalAmount': totalAmount});
    result.addAll({'commercialAmount': commercialAmount});

    return result;
  }

  factory HotelSearchResRoomRate.fromMap(Map<String, dynamic> map) {
    return HotelSearchResRoomRate(
      description: map['description'],
      currency: map['currency'],
      baseRate: map['baseRate']?.toDouble() ?? 0.0,
      exclusive: map['exclusive']?.toDouble() ?? 0.0,
      inclusive: map['inclusive']?.toDouble() ?? 0.0,
      tax: map['tax']?.toDouble() ?? 0.0,
      fees: map['fees']?.toDouble() ?? 0.0,
      hotelDiscount: map['hotelDiscount']?.toDouble() ?? 0.0,
      couponDiscount: map['couponDiscount']?.toDouble() ?? 0.0,
      couponCode: map['couponCode'],
      applicableCouponCode:
          List<String>.from(map['applicableCouponCode'] ?? []),
      method: map['method'],
      totalAmount: map['totalAmount']?.toDouble() ?? 0.0,
      commercialAmount: map['commercialAmount']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory HotelSearchResRoomRate.fromJson(String source) =>
      HotelSearchResRoomRate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HotelSearchResRoomRate(description: $description, currency: $currency, baseRate: $baseRate, exclusive: $exclusive, inclusive: $inclusive, tax: $tax, fees: $fees, hotelDiscount: $hotelDiscount, couponDiscount: $couponDiscount, couponCode: $couponCode, applicableCouponCode: $applicableCouponCode, method: $method, totalAmount: $totalAmount, commercialAmount: $commercialAmount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HotelSearchResRoomRate &&
        other.description == description &&
        other.currency == currency &&
        other.baseRate == baseRate &&
        other.exclusive == exclusive &&
        other.inclusive == inclusive &&
        other.tax == tax &&
        other.fees == fees &&
        other.hotelDiscount == hotelDiscount &&
        other.couponDiscount == couponDiscount &&
        other.couponCode == couponCode &&
        listEquals(other.applicableCouponCode, applicableCouponCode) &&
        other.method == method &&
        other.totalAmount == totalAmount &&
        other.commercialAmount == commercialAmount;
  }

  @override
  int get hashCode {
    return description.hashCode ^
        currency.hashCode ^
        baseRate.hashCode ^
        exclusive.hashCode ^
        inclusive.hashCode ^
        tax.hashCode ^
        fees.hashCode ^
        hotelDiscount.hashCode ^
        couponDiscount.hashCode ^
        couponCode.hashCode ^
        applicableCouponCode.hashCode ^
        method.hashCode ^
        totalAmount.hashCode ^
        commercialAmount.hashCode;
  }
}
