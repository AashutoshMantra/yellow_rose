import 'dart:convert';

class ExpediaHotelSearchRespCancelPenalty {
  final String? currency;
  final String? start;
  final String? end;
  final double? amount;
  final int? nights;
  final double? percent;
  ExpediaHotelSearchRespCancelPenalty({
    this.currency,
    this.start,
    this.end,
    this.amount,
    this.nights,
    this.percent,
  });

  ExpediaHotelSearchRespCancelPenalty copyWith({
    String? currency,
    String? start,
    String? end,
    double? amount,
    int? nights,
    double? percent,
  }) {
    return ExpediaHotelSearchRespCancelPenalty(
      currency: currency ?? this.currency,
      start: start ?? this.start,
      end: end ?? this.end,
      amount: amount ?? this.amount,
      nights: nights ?? this.nights,
      percent: percent ?? this.percent,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(currency != null){
      result.addAll({'currency': currency});
    }
    if(start != null){
      result.addAll({'start': start});
    }
    if(end != null){
      result.addAll({'end': end});
    }
    if(amount != null){
      result.addAll({'amount': amount});
    }
    if(nights != null){
      result.addAll({'nights': nights});
    }
    if(percent != null){
      result.addAll({'percent': percent});
    }
  
    return result;
  }

  factory ExpediaHotelSearchRespCancelPenalty.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespCancelPenalty(
      currency: map['currency'],
      start: map['start'],
      end: map['end'],
      amount: map['amount']?.toDouble(),
      nights: map['nights']?.toInt(),
      percent: map['percent']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespCancelPenalty.fromJson(String source) => ExpediaHotelSearchRespCancelPenalty.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ExpediaHotelSearchRespCancelPenalty(currency: $currency, start: $start, end: $end, amount: $amount, nights: $nights, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaHotelSearchRespCancelPenalty &&
      other.currency == currency &&
      other.start == start &&
      other.end == end &&
      other.amount == amount &&
      other.nights == nights &&
      other.percent == percent;
  }

  @override
  int get hashCode {
    return currency.hashCode ^
      start.hashCode ^
      end.hashCode ^
      amount.hashCode ^
      nights.hashCode ^
      percent.hashCode;
  }
}
