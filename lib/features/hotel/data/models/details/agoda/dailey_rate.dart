import 'dart:convert';

import 'package:flutter/foundation.dart';

class AgodaHotelSearchResDailyRate {
  final String? date;
  final double? exclusive;
  final double? inclusive;
  final double? tax;
  final double? fee;
  final double? processingFee;
  final String? method;
  final Map<String, Object>? additionalProperties;
  AgodaHotelSearchResDailyRate({
    this.date,
    this.exclusive,
    this.inclusive,
    this.tax,
    this.fee,
    this.processingFee,
    this.method,
    this.additionalProperties,
  });

  AgodaHotelSearchResDailyRate copyWith({
    String? date,
    double? exclusive,
    double? inclusive,
    double? tax,
    double? fee,
    double? processingFee,
    String? method,
    Map<String, Object>? additionalProperties,
  }) {
    return AgodaHotelSearchResDailyRate(
      date: date ?? this.date,
      exclusive: exclusive ?? this.exclusive,
      inclusive: inclusive ?? this.inclusive,
      tax: tax ?? this.tax,
      fee: fee ?? this.fee,
      processingFee: processingFee ?? this.processingFee,
      method: method ?? this.method,
      additionalProperties: additionalProperties ?? this.additionalProperties,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(date != null){
      result.addAll({'date': date});
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
    if(processingFee != null){
      result.addAll({'processingFee': processingFee});
    }
    if(method != null){
      result.addAll({'method': method});
    }
    if(additionalProperties != null){
      result.addAll({'additionalProperties': additionalProperties});
    }
  
    return result;
  }

  factory AgodaHotelSearchResDailyRate.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResDailyRate(
      date: map['date'],
      exclusive: map['exclusive']?.toDouble(),
      inclusive: map['inclusive']?.toDouble(),
      tax: map['tax']?.toDouble(),
      fee: map['fee']?.toDouble(),
      processingFee: map['processingFee']?.toDouble(),
      method: map['method'],
      additionalProperties: Map<String, Object>.from(map['additionalProperties']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResDailyRate.fromJson(String source) => AgodaHotelSearchResDailyRate.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResDailyRate(date: $date, exclusive: $exclusive, inclusive: $inclusive, tax: $tax, fee: $fee, processingFee: $processingFee, method: $method, additionalProperties: $additionalProperties)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is AgodaHotelSearchResDailyRate &&
      other.date == date &&
      other.exclusive == exclusive &&
      other.inclusive == inclusive &&
      other.tax == tax &&
      other.fee == fee &&
      other.processingFee == processingFee &&
      other.method == method &&
      mapEquals(other.additionalProperties, additionalProperties);
  }

  @override
  int get hashCode {
    return date.hashCode ^
      exclusive.hashCode ^
      inclusive.hashCode ^
      tax.hashCode ^
      fee.hashCode ^
      processingFee.hashCode ^
      method.hashCode ^
      additionalProperties.hashCode;
  }
}
