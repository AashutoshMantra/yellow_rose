import 'dart:convert';

import 'package:yellow_rose/core/utils/extensions.dart';

enum AgodaTaxBreakDownBase {
  Y("Y"),
  N("N");

  final String value;

  const AgodaTaxBreakDownBase(this.value);
}

class AgodaHotelSearchResTaxBreakdown {
  final String? id;
  final String? typeValue;
  final String? taxDescription;
  final String? translatedTaxDescription;
  final String? method;
  final String? currency;
  final AgodaTaxBreakDownBase? base;
  final AgodaTaxBreakDownBase? taxable;
  final double? percent;
  final double? amount;
  final int? taxProtoTypeId;
  final double? taxDueSupplier;
  AgodaHotelSearchResTaxBreakdown({
    this.id,
    this.typeValue,
    this.taxDescription,
    this.translatedTaxDescription,
    this.method,
    this.currency,
    this.base,
    this.taxable,
    this.percent,
    this.amount,
    this.taxProtoTypeId,
    this.taxDueSupplier,
  });

  AgodaHotelSearchResTaxBreakdown copyWith({
    String? id,
    String? typeValue,
    String? taxDescription,
    String? translatedTaxDescription,
    String? method,
    String? currency,
    AgodaTaxBreakDownBase? base,
    AgodaTaxBreakDownBase? taxable,
    double? percent,
    double? amount,
    int? taxProtoTypeId,
    double? taxDueSupplier,
  }) {
    return AgodaHotelSearchResTaxBreakdown(
      id: id ?? this.id,
      typeValue: typeValue ?? this.typeValue,
      taxDescription: taxDescription ?? this.taxDescription,
      translatedTaxDescription:
          translatedTaxDescription ?? this.translatedTaxDescription,
      method: method ?? this.method,
      currency: currency ?? this.currency,
      base: base ?? this.base,
      taxable: taxable ?? this.taxable,
      percent: percent ?? this.percent,
      amount: amount ?? this.amount,
      taxProtoTypeId: taxProtoTypeId ?? this.taxProtoTypeId,
      taxDueSupplier: taxDueSupplier ?? this.taxDueSupplier,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (id != null) {
      result.addAll({'id': id});
    }
    if (typeValue != null) {
      result.addAll({'typeValue': typeValue});
    }
    if (taxDescription != null) {
      result.addAll({'taxDescription': taxDescription});
    }
    if (translatedTaxDescription != null) {
      result.addAll({'translatedTaxDescription': translatedTaxDescription});
    }
    if (method != null) {
      result.addAll({'method': method});
    }
    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (base != null) {
      result.addAll({'base': base!.name});
    }
    if (taxable != null) {
      result.addAll({'taxable': taxable!.name});
    }
    if (percent != null) {
      result.addAll({'percent': percent});
    }
    if (amount != null) {
      result.addAll({'amount': amount});
    }
    if (taxProtoTypeId != null) {
      result.addAll({'taxProtoTypeId': taxProtoTypeId});
    }
    if (taxDueSupplier != null) {
      result.addAll({'taxDueSupplier': taxDueSupplier});
    }

    return result;
  }

  factory AgodaHotelSearchResTaxBreakdown.fromMap(Map<String, dynamic> map) {
    return AgodaHotelSearchResTaxBreakdown(
      id: map['id'],
      typeValue: map['typeValue'],
      taxDescription: map['taxDescription'],
      translatedTaxDescription: map['translatedTaxDescription'],
      method: map['method'],
      currency: map['currency'],
      base: map['base'] != null
          ? stringToEnum(map['base'], AgodaTaxBreakDownBase.values)
          : null,
      taxable: map['taxable'] != null
          ? stringToEnum(map['taxable'], AgodaTaxBreakDownBase.values)
          : null,
      percent: map['percent']?.toDouble(),
      amount: map['amount']?.toDouble(),
      taxProtoTypeId: map['taxProtoTypeId']?.toInt(),
      taxDueSupplier: map['taxDueSupplier']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AgodaHotelSearchResTaxBreakdown.fromJson(String source) =>
      AgodaHotelSearchResTaxBreakdown.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AgodaHotelSearchResTaxBreakdown(id: $id, typeValue: $typeValue, taxDescription: $taxDescription, translatedTaxDescription: $translatedTaxDescription, method: $method, currency: $currency, base: $base, taxable: $taxable, percent: $percent, amount: $amount, taxProtoTypeId: $taxProtoTypeId, taxDueSupplier: $taxDueSupplier)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AgodaHotelSearchResTaxBreakdown &&
        other.id == id &&
        other.typeValue == typeValue &&
        other.taxDescription == taxDescription &&
        other.translatedTaxDescription == translatedTaxDescription &&
        other.method == method &&
        other.currency == currency &&
        other.base == base &&
        other.taxable == taxable &&
        other.percent == percent &&
        other.amount == amount &&
        other.taxProtoTypeId == taxProtoTypeId &&
        other.taxDueSupplier == taxDueSupplier;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        typeValue.hashCode ^
        taxDescription.hashCode ^
        translatedTaxDescription.hashCode ^
        method.hashCode ^
        currency.hashCode ^
        base.hashCode ^
        taxable.hashCode ^
        percent.hashCode ^
        amount.hashCode ^
        taxProtoTypeId.hashCode ^
        taxDueSupplier.hashCode;
  }
}
