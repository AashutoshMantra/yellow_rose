import 'dart:convert';

class BusCancelaltionChargeDetail {
  String? type;
  String? amount;
  String? status;
  String? currency;
  BusCancelaltionChargeDetail({
    this.type,
    this.amount,
    this.status,
    this.currency,
  });

  BusCancelaltionChargeDetail copyWith({
    String? type,
    String? amount,
    String? status,
    String? currency,
  }) {
    return BusCancelaltionChargeDetail(
      type: type ?? this.type,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      currency: currency ?? this.currency,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (type != null) {
      result.addAll({'type': type});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }

    return result;
  }

  factory BusCancelaltionChargeDetail.fromMap(Map<String, dynamic> map) {
    return BusCancelaltionChargeDetail(
      type: map['type'],
      amount: map['amount'],
      status: map['status'],
      currency: map['currency'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BusCancelaltionChargeDetail.fromJson(String source) =>
      BusCancelaltionChargeDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BusCancelaltionChargeDetail(type: $type, amount: $amount, status: $status, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BusCancelaltionChargeDetail &&
        other.type == type &&
        other.amount == amount &&
        other.status == status &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        currency.hashCode;
  }
}
