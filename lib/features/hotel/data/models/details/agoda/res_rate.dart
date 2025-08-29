import 'dart:convert';

import 'package:yellow_rose/features/hotel/data/models/details/agoda/search_rate_res_pla.dart';

class AgodaHotelSearchResRate {
  final String? currency;
  final double? exclusive;
  final double? inclusive;
  final double? tax;
  final double? fee;
  final String? method;
  final int? stayPackageType;
  final AgodaHotelSearchResRatePlan? ratePlan;
  final double? fees;
  AgodaHotelSearchResRate({
    this.currency,
    this.exclusive,
    this.inclusive,
    this.tax,
    this.fee,
    this.method,
    this.stayPackageType,
    this.ratePlan,
    this.fees,
  });

  AgodaHotelSearchResRate copyWith({
    String? currency,
    double? exclusive,
    double? inclusive,
    double? tax,
    double? fee,
    String? method,
    int? stayPackageType,
    AgodaHotelSearchResRatePlan? ratePlan,
    double? fees,
  }) {
    return AgodaHotelSearchResRate(
      currency: currency ?? this.currency,
      exclusive: exclusive ?? this.exclusive,
      inclusive: inclusive ?? this.inclusive,
      tax: tax ?? this.tax,
      fee: fee ?? this.fee,
      method: method ?? this.method,
      stayPackageType: stayPackageType ?? this.stayPackageType,
      ratePlan: ratePlan ?? this.ratePlan,
      fees: fees ?? this.fees,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(currency != null){
      result.addAll({'currency': currency});
    }
    if(exclusive != null){
      result.addAll({'exclusive': exclusive});
    }
    if(inclusive != null){
      result.addAll({'inclusive': inclusive});
    }
    if(tax != null){
      result.addAll({'tax': tax});
    }
    if(fee != null){
      result.addAll({'fee': fee});
    }
    if(method != null){
      result.addAll({'method': method});
    }
    if(stayPackageType != null){
      result.addAll({'stayPackageType': stayPackageType});
    }
    if(ratePlan != null){
      result.addAll({'ratePlan': ratePlan!.toMap()});
    }
    if(fees != null){
      result.addAll({'fees': fees});
    }
  
    return result;
  }

  factory AgodaHotelSearchResRate.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResRate(
      currency: map['currency'],
      exclusive: map['exclusive']?.toDouble(),
      inclusive: map['inclusive']?.toDouble(),
      tax: map['tax']?.toDouble(),
      fee: map['fee']?.toDouble(),
      method: map['method'],
      stayPackageType: map['stayPackageType']?.toInt(),
      ratePlan: map['ratePlan'] != null ? AgodaHotelSearchResRatePlan.fromMap(map['ratePlan']) : null,
      fees: map['fees']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResRate.fromJson(String source) => AgodaHotelSearchResRate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResRate(currency: $currency, exclusive: $exclusive, inclusive: $inclusive, tax: $tax, fee: $fee, method: $method, stayPackageType: $stayPackageType, ratePlan: $ratePlan, fees: $fees)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResRate &&
      other.currency == currency &&
      other.exclusive == exclusive &&
      other.inclusive == inclusive &&
      other.tax == tax &&
      other.fee == fee &&
      other.method == method &&
      other.stayPackageType == stayPackageType &&
      other.ratePlan == ratePlan &&
      other.fees == fees;
  }

  @override
  int get hashCode {
    return currency.hashCode ^
      exclusive.hashCode ^
      inclusive.hashCode ^
      tax.hashCode ^
      fee.hashCode ^
      method.hashCode ^
      stayPackageType.hashCode ^
      ratePlan.hashCode ^
      fees.hashCode;
  }
}
