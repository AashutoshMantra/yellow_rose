import 'dart:convert';

class ExpediaHotelSearchRespDeposit {
  final String? value;
  final String? due;
  final String? currency;
  ExpediaHotelSearchRespDeposit({
    this.value,
    this.due,
    this.currency,
  });

  ExpediaHotelSearchRespDeposit copyWith({
    String? value,
    String? due,
    String? currency,
  }) {
    return ExpediaHotelSearchRespDeposit(
      value: value ?? this.value,
      due: due ?? this.due,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (value != null) {
      result.addAll({'value': value});
    }
    if (due != null) {
      result.addAll({'due': due});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }

    return result;
  }

  factory ExpediaHotelSearchRespDeposit.fromMap(Map<String, dynamic> map) {
    return ExpediaHotelSearchRespDeposit(
      value: map['value'],
      due: map['due'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelSearchRespDeposit.fromJson(String source) =>
      ExpediaHotelSearchRespDeposit.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelSearchRespDeposit(value: $value, due: $due, currency: $currency)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelSearchRespDeposit &&
        other.value == value &&
        other.due == due &&
        other.currency == currency;
  }

  @override
  int get hashCode => value.hashCode ^ due.hashCode ^ currency.hashCode;
}
