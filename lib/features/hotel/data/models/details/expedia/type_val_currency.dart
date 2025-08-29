import 'dart:convert';

class ExpediaHotelSearchRespTypeValCurr {
  final String? type;
  final double? value;
  final String? currency;
  ExpediaHotelSearchRespTypeValCurr({
    this.type,
    this.value,
    this.currency,
  });

  ExpediaHotelSearchRespTypeValCurr copyWith({
    String? type,
    double? value,
    String? currency,
  }) {
    return ExpediaHotelSearchRespTypeValCurr(
      type: type ?? this.type,
      value: value ?? this.value,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type});
    }
    if (value != null) {
      result.addAll({'value': value});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }

    return result;
  }

  factory ExpediaHotelSearchRespTypeValCurr.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespTypeValCurr(
      type: map['type'],
      value: map['value']?.toDouble(),
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespTypeValCurr.fromJson(String source) =>
      ExpediaHotelSearchRespTypeValCurr.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchRespTypeValCurr(type: $type, value: $value, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchRespTypeValCurr &&
        other.type == type &&
        other.value == value &&
        other.currency == currency;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode ^ currency.hashCode;
}
