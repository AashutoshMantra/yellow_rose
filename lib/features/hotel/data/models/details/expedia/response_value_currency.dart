import 'dart:convert';

class ExpediaHotelSearchRespValueCurrency {
  final double? value;
  final String? currency;
  ExpediaHotelSearchRespValueCurrency({
    this.value,
    this.currency,
  });

  ExpediaHotelSearchRespValueCurrency copyWith({
    double? value,
    String? currency,
  }) {
    return ExpediaHotelSearchRespValueCurrency(
      value: value ?? this.value,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(value != null){
      result.addAll({'value': value});
    }
    if(currency != null){
      result.addAll({'currency': currency});
    }
  
    return result;
  }

  factory ExpediaHotelSearchRespValueCurrency.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespValueCurrency(
      value: map['value']?.toDouble(),
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespValueCurrency.fromJson(String source) => ExpediaHotelSearchRespValueCurrency.fromMap(json.decode(source));

  @override
  String toString() => 'ExpediaHotelSearchRespValueCurrency(value: $value, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ExpediaHotelSearchRespValueCurrency &&
      other.value == value &&
      other.currency == currency;
  }

  @override
  int get hashCode => value.hashCode ^ currency.hashCode;
}
