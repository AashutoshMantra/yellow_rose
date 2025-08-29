import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:yellow_rose/features/hotel/data/models/details/expedia/room/resposne_id_name.dart';

class ExpediaHotelContentResponseOnsitePayment {
  final String? currency;
  final List<ExpediaHotelContentResponseIdName>? types;
  ExpediaHotelContentResponseOnsitePayment({
    this.currency,
    this.types,
  });

  ExpediaHotelContentResponseOnsitePayment copyWith({
    String? currency,
    List<ExpediaHotelContentResponseIdName>? types,
  }) {
    return ExpediaHotelContentResponseOnsitePayment(
      currency: currency ?? this.currency,
      types: types ?? this.types,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (currency != null) {
      result.addAll({'currency': currency});
    }
    if (types != null) {
      result.addAll({'types': types!.map((x) => x.toMap()).toList()});
    }

    return result;
  }

  factory ExpediaHotelContentResponseOnsitePayment.fromMap(
      Map<String, dynamic> map) {
    return ExpediaHotelContentResponseOnsitePayment(
      currency: map['currency'],
      types: map['types'] != null
          ? List<ExpediaHotelContentResponseIdName>.from(map['types']
              ?.map((x) => ExpediaHotelContentResponseIdName.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpediaHotelContentResponseOnsitePayment.fromJson(String source) =>
      ExpediaHotelContentResponseOnsitePayment.fromMap(json.decode(source));

  @override
  String toString() =>
      'ExpediaHotelContentResponseOnsitePayment(currency: $currency, types: $types)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExpediaHotelContentResponseOnsitePayment &&
        other.currency == currency &&
        listEquals(other.types, types);
  }

  @override
  int get hashCode => currency.hashCode ^ types.hashCode;
}
